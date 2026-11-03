# Safety, scope, and privacy

This repository is for defensive education. Keep all activity inside an isolated lab or within a clearly authorized scope.

## Allowed practice

- Analyze the synthetic files included in the repository's labs.
- Query logs on a machine you own or are explicitly authorized to investigate.
- Write and test detections against sample data.
- Record uncertainty, benign explanations, and evidence supporting each conclusion.

## Out of scope

- Testing credentials or triggering authentication failures against real accounts or third-party systems.
- Deploying malware, exploits, persistence, or payloads.
- Scanning, probing, or collecting data from systems without explicit authorization.
- Uploading real `.evtx`, packet captures, email, endpoint telemetry, or incident records to a public repository.

## Privacy checklist before publishing

1. Replace real usernames, email addresses, hostnames, domains, IPs, and organization names with synthetic values.
2. Remove tokens, cookies, passwords, private keys, internal URLs, and unique identifiers.
3. Check screenshots for desktop notifications, browser tabs, file paths, and account details.
4. Verify that every sample is synthetic or approved for public release.
5. Keep original evidence private and preserve it according to your organization's policy.

The included sample IPv4 addresses come from documentation ranges (`192.0.2.0/24`, `198.51.100.0/24`, and `203.0.113.0/24`) and are not real indicators.
