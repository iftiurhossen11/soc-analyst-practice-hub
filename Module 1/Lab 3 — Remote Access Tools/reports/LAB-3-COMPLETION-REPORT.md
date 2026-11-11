# Lab 3 Completion Report — Remote Access and File Transfer Tools

## Source and privacy note

This summary is based on the supplied `Remote_Access_Tools_Lab_Report.pdf`. The original describes a Windows host connecting to a Kali Linux VM and covers FileZilla Client, WinSCP, PuTTY, and MobaXterm. The original PDF remains in the local workspace but is excluded from Git because it includes personal and machine-identifying details. The `screenshots/` folder contains redacted copies of the main screenshots embedded in the original report.

## Exercise summary

The supplied report documents installation and use of four remote-access clients:

| Tool | Protocol used | Reported role |
|---|---|---|
| FileZilla Client | SFTP | Graphical file transfer |
| WinSCP | SFTP | Graphical file transfer and file management |
| PuTTY | SSH | Remote terminal |
| MobaXterm | SSH / SFTP | Remote terminal with an SFTP browser |

The reported server was a Kali Linux VM with an SSH service. The clients used SSH/SFTP over TCP port 22, and the report documents successful terminal access and graphical file browsing, along with a described file-transfer workflow.

## Security assessment

- SSH/SFTP encrypts the session in transit; plain FTP and Telnet should not be substituted for this exercise.
- The source report describes accepting first-connection host-key prompts, but does not document an independent fingerprint comparison. A public completion report therefore cannot claim that host identity was verified.
- The source describes both host-only and NAT adapters on the Kali VM, so the setup was not fully isolated from outbound networking. This lab removes NAT before the exercise and uses only host-only connectivity between systems the learner owns or is authorized to administer. Do not use bridged networking or third-party targets.
- Use a dedicated lab account and harmless test files. Do not save real credentials or transfer private keys or production data.
- Stop the SSH service and remove the test file and saved client sessions after the exercise.

## Limitations

This report summarizes the supplied exercise and is not an independent rerun or audit. It does not establish that the source environment was properly isolated, that host keys were verified, that credentials were strong, or that any remote access was authorized. The report template records these checks for a safe repeat of the lab.

## Recommended next steps

1. Repeat the exercise in a host-only VM network and verify the host-key fingerprint before accepting it.
2. Transfer a harmless test file and compare its SHA-256 hash on both systems.
3. Complete the [report template](REMOTE-ACCESS-TOOLS-REPORT-TEMPLATE.md) using only sanitized lab details.
4. Before publishing a copy of the original PDF, remove personal identifiers, account/device details, profile paths, private network information, and any sensitive content visible in screenshots.
