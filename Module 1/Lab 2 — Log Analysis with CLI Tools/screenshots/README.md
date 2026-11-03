# Screenshot Evidence Guide

The `kali-*.png` images in this folder are real captures from the Kali Linux VM used to execute the lab. They are not screenshots of a real production system. The published text output in `../artifacts/analysis-output-example.md` remains available for copyable, reproducible evidence.

Before adding an image, check that it contains no usernames, home-directory paths, tokens, URLs from real environments, cookies, or credentials. Prefer synthetic screenshots with the repository's sample data.

## Kali VM evidence

The following captures document the same workflow executed inside the user's Kali Linux VirtualBox VM:

- `kali-00-environment.png` — Kali terminal environment and lab workspace setup.
- `kali-01-log-sample.png` — `head` output showing the first five records.
- `kali-02-request-count.png` — `wc -l` request count.
- `kali-03-status-codes.png` — `awk`, `sort`, and `uniq` status-code review.
- `kali-04-nikto-activity.png` — bounded Nikto user-agent search.
- `kali-05-sql-patterns.png` — bounded SQL-like indicator search.
- `kali-06-http-methods.png` — HTTP method distribution.
- `kali-07-sed-review.png` — compact timestamp review with `sed`.
- `kali-08-cut-fields.png` — client and request fields with `cut`.
- `kali-09-full-runner.png` — complete exercise runner execution.
- `kali-10-generated-report.png` — generated report output reviewed in Kali.
