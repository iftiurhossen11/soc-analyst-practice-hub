# Lab 2 Completion Report — Log Analysis with CLI Tools

## Execution note

This completion report uses the repository-provided synthetic Apache Combined Log Format dataset. The complete exercise was executed in the user's Kali Linux VirtualBox VM, with supporting local validation in Git Bash. No external URL, production server, real log, credential, or third-party system was accessed.

The Kali execution evidence is included in the companion DOCX report and in the `screenshots/kali-*.png` files. Kali is an accepted Linux environment for this exercise; Ubuntu is not required.

## Part 1 — Apache log format

The sample contains the client address, identity, username, timestamp, request method/path/protocol, status code, response size, referrer, and user agent fields. The first five records were reviewed with `head`.

## Part 2 — Basic analysis

| Exercise | Command focus | Observed result |
|---|---|---|
| Total requests | `wc -l` | 13 requests |
| Unique clients | `awk`, `sort -u`, `uniq`, `wc -l` | 4 source addresses |
| Top talkers | `awk`, `sort`, `uniq -c`, `sort -rn` | `203.0.113.44` generated 6 requests |
| Status codes | `awk '$9 == 404'` and status grouping | 5×200, 3×404, 3×400, 2×401 |
| Top 404 paths | `awk`, `sort`, `uniq -c` | `/admin/config.php`, `/.env`, `/wp-admin/` |

The administrative and configuration paths are reconnaissance leads. The 404 responses indicate that these paths were not found in the sample; they do not prove access or compromise.

## Part 3 — Pattern matching

| Indicator | Result | Interpretation |
|---|---:|---|
| Nikto user agent | 3 | Scanner-like activity; could be authorized testing |
| SQL-like request | 1 | Possible injection probe; requires application telemetry |
| XSS-like request | 1 | Possible input probe; no proof of execution |
| Directory traversal-like request | 1 | Possible file-path probe; no proof of file access |

The matching source in this dataset is `203.0.113.44`, a documentation-only address. User agents and request strings are client-controlled and must not be treated as attribution.

## Part 4 — Advanced `awk`, `sed`, and `cut`

- Traffic by hour: 12 requests occurred during hour `03`; 1 occurred during hour `14`.
- HTTP methods: 11 `GET` requests and 2 `POST` requests.
- User agents: Mozilla, Nikto, curl, and SyntheticMonitor values are present.
- `sed` was used to trim each record after the timestamp for a compact view.
- `cut` was used to show the first and request fields.
- Source addresses were anonymized to `/24`-style values before public reporting.

## Conclusion

The exercise produced a reproducible offline review of volume, clients, paths, status codes, methods, timing, user agents, and web-attack-like request patterns. The data supports prioritizing `203.0.113.44` for correlation, but it does not establish exploitation, compromise, authorization status, or attribution.

## Recommended next steps

1. Correlate requests with application and WAF logs.
2. Verify whether the activity was approved security testing.
3. Review authentication and endpoint telemetry for related activity.
4. Preserve the relevant request context before changing or blocking anything.
