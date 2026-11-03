[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [ValidateRange(1, 720)]
    [int]$Hours = 24,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $InputPath -PathType Leaf)) {
    throw "Input CSV was not found: $InputPath"
}

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
if ([string]::Equals($resolvedInput, $resolvedOutput, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'OutputPath must not overwrite the input CSV.'
}
if ((Test-Path -LiteralPath $resolvedOutput) -and -not $Force) {
    throw "Output already exists: $resolvedOutput. Choose a new path or pass -Force to overwrite it."
}

$rows = @(Import-Csv -LiteralPath $resolvedInput)
if ($rows.Count -eq 0) {
    throw "Input CSV contains no records: $resolvedInput"
}

$requiredColumns = @('timestamp', 'event_id', 'account', 'source_ip', 'logon_type', 'host', 'action', 'details')
$availableColumns = @($rows[0].PSObject.Properties.Name)
foreach ($column in $requiredColumns) {
    if ($availableColumns -notcontains $column) {
        throw "Input CSV is missing required column '$column'. Required columns: $($requiredColumns -join ', ')"
    }
}

$events = @(
    for ($index = 0; $index -lt $rows.Count; $index++) {
        $row = $rows[$index]
        try {
            $timestamp = [DateTimeOffset]::Parse(
                $row.timestamp,
                [System.Globalization.CultureInfo]::InvariantCulture
            )
        }
        catch {
            throw "Invalid timestamp on CSV data row $($index + 2): '$($row.timestamp)'. Use an ISO 8601 timestamp with a time zone."
        }

        if ($row.event_id -notmatch '^\d+$') {
            throw "Invalid event_id on CSV data row $($index + 2): '$($row.event_id)'."
        }

        [pscustomobject]@{
            Timestamp = $timestamp
            EventId   = [int]$row.event_id
            Account   = [string]$row.account
            SourceIp  = [string]$row.source_ip
            LogonType = [string]$row.logon_type
            Host      = [string]$row.host
            Action    = [string]$row.action
            Details   = [string]$row.details
        }
    }
)

$referenceTime = ($events | Measure-Object -Property Timestamp -Maximum).Maximum
$windowStart = $referenceTime.AddHours(-$Hours)
$windowEvents = @($events | Where-Object { $_.Timestamp -ge $windowStart -and $_.Timestamp -le $referenceTime })
$failedLogons = @($windowEvents | Where-Object { $_.EventId -eq 4625 })
$successfulLogons = @($windowEvents | Where-Object { $_.EventId -eq 4624 })

$topSources = @(
    $failedLogons |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_.SourceIp) -and $_.SourceIp -ne '-' } |
        Group-Object -Property SourceIp |
        Sort-Object -Property Count -Descending |
        Select-Object -First 5
)
$topAccounts = @(
    $failedLogons |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_.Account) -and $_.Account -ne '-' } |
        Group-Object -Property Account |
        Sort-Object -Property Count -Descending |
        Select-Object -First 5
)
$reviewEvents = @(
    $windowEvents |
        Where-Object { $_.EventId -in @(4648, 4672, 4720, 4724, 4732, 5140) } |
        Group-Object -Property EventId |
        Sort-Object { [int]$_.Name }
)

$report = @(
    '# Windows Security Event Analysis'
    ''
    '> Offline analysis of the supplied CSV. The reference time is the newest event in the dataset; the window is relative to that event, not the current clock.'
    ''
    " - **Input:** ``$([System.IO.Path]::GetFileName($resolvedInput))``"
    " - **Window:** $($windowStart.ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ssZ')) to $($referenceTime.ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ssZ'))"
    " - **Records in window:** $($windowEvents.Count)"
    " - **Failed logons (4625):** $($failedLogons.Count)"
    " - **Successful logons (4624):** $($successfulLogons.Count)"
    ''
    '## Top sources among failed logons'
    ''
)

if ($topSources.Count -eq 0) {
    $report += '- No source addresses were available in failed-logon records.'
}
else {
    foreach ($source in $topSources) {
        $report += "- Source IP: $($source.Name) - $($source.Count) event(s)"
    }
}

$report += @(
    ''
    '## Most-targeted accounts'
    ''
)
if ($topAccounts.Count -eq 0) {
    $report += '- No account names were available in failed-logon records.'
}
else {
    foreach ($account in $topAccounts) {
        $report += "- Account: $($account.Name) - $($account.Count) event(s)"
    }
}

$report += @(
    ''
    '## Other review-worthy event counts'
    ''
)
if ($reviewEvents.Count -eq 0) {
    $report += '- None in this time window.'
}
else {
    foreach ($group in $reviewEvents) {
        $report += "- Event ID $($group.Name): $($group.Count)"
    }
}

$report += @(
    ''
    '## Analyst notes'
    ''
    '- A repeated failure or a success after failures is an investigative lead, not proof of compromise.'
    '- Correlate account, source, host, logon type, approved activity, and relevant endpoint/network evidence.'
    '- This synthetic dataset does not establish real-world attribution or intent.'
    ''
)

$outputDirectory = Split-Path -Parent $resolvedOutput
if ($outputDirectory -and -not (Test-Path -LiteralPath $outputDirectory -PathType Container)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
}

Set-Content -LiteralPath $resolvedOutput -Value $report -Encoding UTF8
Write-Output "Report written to: $resolvedOutput"
Write-Output "Events analyzed: $($windowEvents.Count); failed logons: $($failedLogons.Count); successful logons: $($successfulLogons.Count)"
