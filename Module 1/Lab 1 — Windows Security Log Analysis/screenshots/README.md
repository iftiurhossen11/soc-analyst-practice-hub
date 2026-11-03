# Lab 01 Screenshot Guide

The first 23 images are renamed copies of screenshots supplied with the training material. Personal Windows account and device names have been redacted for public sharing. The original screenshots contain real local Security log records; event counts, timestamps, and process details have not been presented as synthetic.

The final two images are clearly labeled demonstrations created from synthetic training data. They are not captures from a live Windows machine or Event Viewer.

| File | What it shows |
|---|---|
| `01-powershell-version.png` | PowerShell 5.1 version check. |
| `02-recent-security-events.png` | Query for the ten most recent Windows Security events. |
| `03-filter-successful-logons.png` | Filter for successful logon events (Event ID 4624). |
| `04-format-successful-logons.png` | Display selected successful-logon fields in a table. |
| `05-filter-security-events-time-range.png` | Query Security events from the previous 24 hours. |
| `06-time-range-event-results.png` | Sample results returned by the time-range query. |
| `07-last-hour-event-results.png` | Security events returned by the one-hour query. |
| `08-failed-logon-event-details.png` | First portion of a failed-logon event's detailed properties. |
| `09-failed-logon-details-continuation.png` | Remaining authentication, process, and network fields from that event. |
| `10-failed-logon-event-xml.png` | Event XML with named Security event fields. |
| `11-failed-logon-summary-table.png` | Selected fields from failed-logon records in a table. |
| `12-source-ip-analysis-query.png` | PowerShell pipeline for grouping failures by source address. |
| `13-top-targeted-accounts.png` | Failed-logon counts grouped by target account. |
| `14-failed-logons-by-type.png` | Failed-logon grouping by logon type. |
| `15-explicit-credentials-events.png` | Event ID 4648 review, including process and target context. |
| `16-special-privilege-events.png` | Event ID 4672 review by account and logon session. |
| `17-analysis-script-initialization.png` | Beginning of the reusable Windows log analysis script. |
| `18-failed-logon-analysis-output.png` | Failed-logon analysis section of the script output. |
| `19-successful-logon-analysis-output.png` | Successful-logon counts and logon-type distribution. |
| `20-account-management-analysis-output.png` | Account-management event review. |
| `21-privilege-indicator-analysis-output.png` | Counts for privilege-related events. |
| `22-csv-export-command.png` | Export of selected failed-logon fields to CSV. |
| `23-html-report-export-command.png` | Creation of an HTML summary report. |
| `24-offline-analyzer-synthetic-demo.png` | Output of the repository's offline analyzer using the bundled synthetic CSV. |
| `25-event-viewer-synthetic-demo.png` | Illustrative Event Viewer-style view of synthetic events; not a live system screenshot. |

These images document the original exercise sequence; the newer offline analyzer and safety notes are documented in the [lab guide](../README.md). Never publish unredacted source logs or screenshots from a real environment.
