# SOC Analyst Practice Hub

Hands-on, defensive SOC practice using synthetic data and systems you own or are explicitly authorized to investigate.

This repository organizes defensive SOC analyst training into Module 1 and its hands-on labs. Lab 1 contains the earlier SOC practice material, while Lab 2 covers Apache log analysis with CLI tools.

## Learning path

| Module | Focus | Lab output |
|---|---|---|
| Module 1 Lab 1 | Earlier SOC practice and capstone material | [Windows Security Log Analysis](<Module 1/Lab 1 — Windows Security Log Analysis/README.md>) |
| Module 1 Lab 2 | Log analysis with Linux CLI tools | [Apache Log Analysis](<Module 1/Lab 2 — Log Analysis with CLI Tools/README.md>) |

Start with [Module 1](<Module 1/README.md>). Every dataset is synthetic; sample IPs use documentation-only ranges.

## Quick start

Requirements for Module 1, Lab 1:

- Windows PowerShell 5.1 or PowerShell 7
- No administrator rights or external services are needed for the offline exercise

From the [Lab 1 directory](<Module 1/Lab 1 — Windows Security Log Analysis/>):

```powershell
.\tools\Analyze-SecurityEvents.ps1 `
  -InputPath .\data\windows-security-events.csv `
  -OutputPath .\output\windows-security-analysis.md
```

The script reads only the supplied CSV and writes the report at the path you specify. It does not query or change Windows logs, create test events, contact a network, or change execution policy. If the output already exists, choose another path or explicitly pass `-Force`.

## Repository layout

```text
Module 1/       Module 1 Windows Security logs and PowerShell
  README.md
  Lab 1 — Windows Security Log Analysis/  Lab 1 with the earlier practice material
    supporting-labs/  Additional earlier lab material and capstone
  Lab 2 — Log Analysis with CLI Tools/  Lab 2 with CLI log analysis
```

## Safety and privacy

- Use only data and systems you own or have explicit permission to investigate.
- Do not run password-guessing, malware, exploit, or unauthorized authentication tests.
- Do not publish real event logs, `.evtx` files, screenshots, usernames, hostnames, tokens, or customer data.
- The screenshots supplied with the source material show a real Windows profile, computer name, and Security log activity. The published copies have account and device identifiers redacted; never publish the unredacted originals. See the [Module 1 screenshot guide](<Module 1/Lab 1 — Windows Security Log Analysis/screenshots/README.md>) for image descriptions and synthetic demonstrations.
- All findings are hypotheses until validated against authorized, relevant context. A single event is not proof of compromise.

See [SAFETY.md](SAFETY.md) before starting. Contributions and lab reports should use synthetic or properly sanitized data.
