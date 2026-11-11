# Remote Access and File Transfer Tools Lab Report

- **Analyst:**
- **Date:**
- **Client platform:**
- **Lab server platform:**
- **Network isolation:** Confirm host-only / Other (explain):

## Executive summary

Summarize the authorized lab activity and its outcome. Do not claim that a connection is secure solely because it succeeded.

## Environment and scope

- Authorized host and VM:
- Network type:
- SSH service state before and after the lab:
- Client tools tested:

Use placeholders such as `[HOST-ONLY-IP]` and `[LAB-USER]` in any public copy. Never include a password, private key, real user or device identifier, or an external target.

## Connection results

| Client | Protocol | Connected? | Host-key fingerprint verified? | Interface / observations |
|---|---|---|---|---|
| FileZilla Client | SFTP | | | |
| WinSCP | SFTP | | | |
| PuTTY | SSH | | | |
| MobaXterm | SSH / SFTP | | | |

## File-transfer integrity

- Test file name (non-sensitive):
- SHA-256 on host:
- SHA-256 on VM:
- Hashes matched:
- Transfer direction(s):

## Security observations

- How was the host-key fingerprint verified?
- What would you do if a fingerprint changed unexpectedly?
- Which authentication method was used, and how were secrets protected?
- What evidence would an administrator retain for an authorized remote session?

## Limitations and benign explanations

State what this lab did not test. A successful SSH/SFTP connection does not prove authorization, appropriate access, or absence of other activity.

## Cleanup

- Test file removed:
- Saved credentials or sessions removed:
- SSH service stopped:
- VM remains isolated:

## Evidence checklist

- [ ] Screenshots contain no usernames, profile paths, hostnames, credentials, tokens, or real network details.
- [ ] Fingerprint comparison is documented without exposing private keys.
- [ ] Only synthetic or authorized lab data is included.
