# Module 1 · Lab 1 — Windows Security Log Analysis

**Module:** 01 · **Level:** beginner to intermediate · **Estimated time:** 3–4 hours

This lab groups the Windows Security event-log exercises, synthetic sample data, offline analyzer, report template, and evidence guidance in one place.

## Objectives

- Explain common Security event IDs and logon types.
- Filter events by ID and time range with `Get-WinEvent`.
- Extract named event fields rather than relying on fragile property-array indexes.
- Distinguish an investigative lead from a confirmed incident.
- Produce a concise, reproducible investigation report.

## Event IDs to recognize

| Event ID | Meaning | Investigation use |
|---:|---|---|
| 4624 | Successful logon | Identify account, logon type, source, and context |
| 4625 | Failed logon | Group failures by account, source, and time |
| 4648 | Explicit credentials used | Review process and target in context |
| 4672 | Special privileges assigned | Correlate with the account and logon session |
| 4720 | User account created | Confirm whether the change was approved |
| 4724 | Password reset attempted | Review the target and initiating account |
| 4732 | Member added to a local security group | Validate group membership changes |
| 5140 | Network share accessed | Review account, share, and source |

Event IDs are clues, not verdicts. Normal administration can generate many of these records.

## Part 1 — Recognize the event

Review the Event ID table above and this abbreviated logon type reference:

| Logon type | Common description |
|---:|---|
| 2 | Interactive |
| 3 | Network |
| 4 | Batch |
| 5 | Service |
| 7 | Unlock |
| 8 | NetworkCleartext |
| 9 | NewCredentials |
| 10 | RemoteInteractive (commonly RDP) |
| 11 | CachedInteractive |

Descriptions are context, not proof of an attack. Validate the event version and surrounding telemetry.

## Part 2 — Read-only queries on an authorized Windows lab machine (optional)

Run these commands only on a machine you own or are explicitly authorized to investigate. They read the local Security log and do not create or modify events. If access is denied or the log is unavailable, stop and use the offline dataset below. Do not change execution policy just to run these commands.

### Exercises 1–4: filter and count

```powershell
# 1. Show up to ten recent Security log events.
Get-WinEvent -LogName Security -MaxEvents 10

# 2. Show recent successful logons.
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4624
} -MaxEvents 20

# 3. Read Security events from the previous 24 hours.
$start = (Get-Date).AddHours(-24)
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    StartTime = $start
} -MaxEvents 100

# 4. Count failed logons in the previous 24 hours.
$failed = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
    StartTime = $start
}
$failed.Count
```

### Exercises 5–9: inspect and summarize named fields

Inspect the XML of one event. The field names below are more reliable than fixed `Properties[]` indexes, which can vary with event versions.

```powershell
$event = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
} -MaxEvents 1

if ($null -ne $event) {
    [xml]$xml = $event.ToXml()
    $fields = @{}
    foreach ($item in $xml.Event.EventData.Data) {
        $fields[[string]$item.Name] = [string]$item.'#text'
    }

    [pscustomobject]@{
        TimeCreated    = $event.TimeCreated
        TargetUserName = $fields['TargetUserName']
        IpAddress      = $fields['IpAddress']
        LogonType      = $fields['LogonType']
        Status         = $fields['Status']
        SubStatus      = $fields['SubStatus']
    }
}
```

Complete these investigations using the same named-field extraction approach:

5. Inspect the event XML and note which fields are actually present.
6. Summarize failed logons by target account, source address, and logon type.
7. Identify the most frequent source addresses among failures.
8. Identify the most frequently targeted accounts.
9. Compare failures by logon type and list plausible benign causes.

Do not treat missing source addresses (`-`, blank, or loopback) as a remote source. Event schema and available fields vary.

### Exercises 10–15: assess activity in context

10. Define a review threshold and time window for repeated failures. Explain why the threshold is not a verdict.
11. Validate the logic against this lab's synthetic CSV. Do not generate failed sign-ins or test passwords on a real account or service.
12. Review Event ID 4648 for explicit-credential use and identify the process/account context.
13. Review Event ID 5140 for share access and identify the share, account, and source fields when available.
14. Review Event ID 4732 for local security group membership changes and determine whether the change is expected.
15. Review Event ID 4672 and correlate it with the account and logon session before escalating.

For these event types, inspect each event's XML and use its `<Data Name="...">` values. Field names differ by Event ID; verify them in the event rather than assuming an index.

## Part 3 — Offline investigation (works without admin rights)

Use the [synthetic dataset](data/windows-security-events.csv). It is deliberately small and contains a short burst of failed logons followed by a successful logon, plus account and privilege events.

### Exercises 16–18: analyze and report

Run the analyzer from this lab's folder:

   ```powershell
   .\tools\Analyze-SecurityEvents.ps1 `
     -InputPath .\data\windows-security-events.csv `
     -OutputPath .\output\windows-security-analysis.md
   ```

16. Review the summary and explain the burst, later successful logon, and account/group events. State what additional evidence is needed before escalating.
17. Complete the [incident report template](REPORT-TEMPLATE.md), citing your analysis, limitations, alternatives, and recommendations.
18. Review the [evidence checklist](screenshots/README.md). Do not publish unredacted screenshots or real logs.

## Visual evidence

The following redacted and synthetic screenshots are placed beside this lab so each exercise can be reviewed with its corresponding evidence. Open the [complete screenshot catalog](screenshots/README.md) for the explanation of every image.

### Event-log queries

| Exercise evidence | Screenshot |
|---|---|
| PowerShell version and recent Security events | ![PowerShell version](screenshots/01-powershell-version.png) ![Recent Security events](screenshots/02-recent-security-events.png) |
| Successful logon filtering and formatted fields | ![Successful logon filter](screenshots/03-filter-successful-logons.png) ![Formatted successful logons](screenshots/04-format-successful-logons.png) |
| Time-range queries and returned events | ![Time-range query](screenshots/05-filter-security-events-time-range.png) ![Time-range results](screenshots/06-time-range-event-results.png) ![Recent event results](screenshots/07-last-hour-event-results.png) |

### Failed-logon investigation

| Exercise evidence | Screenshot |
|---|---|
| Failed-logon details and named XML fields | ![Failed-logon details](screenshots/08-failed-logon-event-details.png) ![Failed-logon continuation](screenshots/09-failed-logon-details-continuation.png) ![Failed-logon XML](screenshots/10-failed-logon-event-xml.png) |
| Grouping failures by source, account, and logon type | ![Failed-logon summary](screenshots/11-failed-logon-summary-table.png) ![Source analysis](screenshots/12-source-ip-analysis-query.png) ![Targeted accounts](screenshots/13-top-targeted-accounts.png) ![Logon types](screenshots/14-failed-logons-by-type.png) |
| Explicit credentials and special privileges | ![Explicit credentials](screenshots/15-explicit-credentials-events.png) ![Special privileges](screenshots/16-special-privilege-events.png) |

### Offline analysis and reporting

| Exercise evidence | Screenshot |
|---|---|
| Analyzer setup and failed/successful logon results | ![Analyzer initialization](screenshots/17-analysis-script-initialization.png) ![Failed-logon output](screenshots/18-failed-logon-analysis-output.png) ![Successful-logon output](screenshots/19-successful-logon-analysis-output.png) |
| Account and privilege indicators | ![Account-management output](screenshots/20-account-management-analysis-output.png) ![Privilege-indicator output](screenshots/21-privilege-indicator-analysis-output.png) |
| Exporting evidence for a report | ![CSV export](screenshots/22-csv-export-command.png) ![HTML report export](screenshots/23-html-report-export-command.png) |
| Safe synthetic demonstrations | ![Offline analyzer demonstration](screenshots/24-offline-analyzer-synthetic-demo.png) ![Synthetic Event Viewer demonstration](screenshots/25-event-viewer-synthetic-demo.png) |

The script reads only the supplied CSV. Its time window is relative to the newest event in the dataset, not the current clock. It does not query live logs or write to Windows event channels. Choose a new output path or pass `-Force` to overwrite a generated report; output files stay local and are ignored by Git.

For a complete readable evidence report, see [`reports/WINDOWS-SECURITY-LOG-ANALYSIS-REPORT.pdf`](reports/WINDOWS-SECURITY-LOG-ANALYSIS-REPORT.pdf). It includes the findings, explanations, limitations, recommendations, timeline, and screenshot catalog.

**Questions**

- Which synthetic source address had the most failed logons? Is that alone proof of a brute-force incident?
- Did a successful logon follow the failures? What fields would you correlate before making a claim?
- Which events might be routine administration? What would you ask the system owner?
- What evidence is missing from this CSV compared with a full Windows event record?

## Deliverable

Write a short report using [the incident report template](REPORT-TEMPLATE.md). Include scope, time range, query, observations, alternative explanations, confidence, and next steps. Use the screenshot catalog to identify supporting evidence, and never publish real logs or screenshots.

## Completion checklist

- [ ] Used the offline analyzer and reviewed its output
- [ ] Correlated failures with other event types without overstating the evidence
- [ ] Documented limitations and benign possibilities
- [ ] Kept generated reports and any real evidence out of version control
