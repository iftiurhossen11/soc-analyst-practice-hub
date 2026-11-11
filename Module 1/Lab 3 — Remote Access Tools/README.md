# Module 1 · Lab 3 — Remote Access and File Transfer Tools

**Module:** 1 · **Level:** beginner · **Estimated time:** 2–3 hours

## Scenario

You are a SOC analyst administering a Linux virtual machine that you own from your Windows host. Use SSH for a remote terminal and SFTP for file transfer, and document how each client supports secure remote administration.

Keep the exercise on a VirtualBox **host-only** network between your own host and VM. Do not use a bridged adapter or connect to a third-party system. The supplied source report used real account and device details; those details are intentionally omitted from the public lab materials.

## Learning outcomes

- Distinguish SSH terminal clients from graphical SFTP clients.
- Connect with SSH/SFTP using a host-only VM address and TCP port 22.
- Verify the SSH server host-key fingerprint before trusting it.
- Transfer a harmless test file and verify its integrity.
- Identify security controls and evidence needed to audit remote access.

## Prerequisites

- A Windows host and a Linux VM that you own or are authorized to administer.
- Oracle VirtualBox or an equivalent local hypervisor.
- A host-only virtual network connecting only the host and the lab VM.
- No production credentials, customer files, or sensitive data.
- The client applications installed from their official vendor websites.

## Contents

- [`data/remote-access-test.txt`](data/remote-access-test.txt) — harmless sample file for SFTP transfer and hash comparison
- [`reports/LAB-3-COMPLETION-REPORT.md`](reports/LAB-3-COMPLETION-REPORT.md) — sanitized summary of the supplied lab report
- [`reports/REMOTE-ACCESS-TOOLS-REPORT-TEMPLATE.md`](reports/REMOTE-ACCESS-TOOLS-REPORT-TEMPLATE.md) — report template for a repeat of the exercise
- [`screenshots/private/`](screenshots/private/) — exact original screenshots extracted from the source PDF; local-only and Git-ignored

## Tools covered

| Tool | Use in this lab |
|---|---|
| FileZilla Client | Graphical SFTP file transfer |
| WinSCP | Graphical SFTP file transfer and file management |
| PuTTY | SSH terminal |
| MobaXterm | SSH terminal with an SFTP browser |

Install client software only from each vendor's official website. Select the FileZilla **Client**, not FileZilla Server. Review installer options and do not install bundled software you did not choose.

## Exercises

1. Prepare the Linux VM as an SSH server.
2. Verify the SSH service and record its host-only IP address.
3. Compare the server host-key fingerprint before accepting it in a client.
4. Connect with FileZilla, WinSCP, PuTTY, and MobaXterm; note each tool's interface and purpose.
5. Transfer a harmless test file with SFTP, then compare SHA-256 hashes on the host and VM.
6. Document results with the report template, keeping identifiers and credentials out of evidence.

### Prepare the isolated SSH/SFTP server

1. If OpenSSH Server is missing, install it from the Linux distribution's official package repository using an authorized, temporary internet connection. For Debian-based distributions:

   ```bash
   sudo apt update
   sudo apt install openssh-server
   ```

2. Shut down the VM, disconnect any NAT adapter, configure the lab adapter as **host-only**, and boot the VM. Do not use bridged mode or expose SSH to the internet.
3. Start the SSH service and confirm its status:

   ```bash
   sudo systemctl start ssh
   sudo systemctl status ssh
   ```

4. Find the VM's host-only address with `ip -brief address`. Use only that address from the Windows host.
5. On the VM, display the SSH host-key fingerprint:

   ```bash
   sudo ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
   ```

   Compare the fingerprint shown by each client with this value before accepting the host key. If they differ, stop and investigate; do not bypass the warning.

### Connect with each client

Use the VM's host-only address, port `22`, and a dedicated lab account. Do not save passwords in the client or reuse a real account password.

1. In FileZilla, choose **SFTP** and enter the lab VM connection details.
2. In WinSCP, choose **SFTP** and enter the same details.
3. In PuTTY, choose **SSH**, port `22`, and the same host-only address.
4. In MobaXterm, create an **SSH** session to the same host-only address.
5. Verify the host-key fingerprint before trusting the first connection. Record whether each tool provides a terminal, file browser, or both.

### Transfer and verify a harmless test file

Use the supplied harmless sample file. Transfer it to the VM with FileZilla or WinSCP, then transfer it back to a different local folder so the original remains unchanged. Compare hashes on both systems:

```powershell
Get-FileHash .\remote-access-test.txt -Algorithm SHA256
```

```bash
sha256sum remote-access-test.txt
```

Do not transfer private keys, SSH configuration, logs from real systems, or other sensitive files.

Run the host-side command from the folder containing the downloaded test file. Run `sha256sum` on the corresponding file on the VM. Matching hashes show that the copies are identical; they do not prove the file or session is otherwise safe.

See the [completion report](reports/LAB-3-COMPLETION-REPORT.md) for a sanitized summary of the supplied report. It is not a substitute for recording results from your own rerun.

## Evidence and reporting

Complete the [report template](reports/REMOTE-ACCESS-TOOLS-REPORT-TEMPLATE.md). Record the protocol, port, independently verified fingerprint result, test-file hash comparison, client differences, and any connection errors. Keep all evidence sanitized.

| Exercise | Evidence to record |
|---|---|
| VM network and SSH service | Host-only configuration and service status, with identifying details redacted |
| Host identity | Whether the fingerprint was compared to the VM's displayed fingerprint |
| Client comparison | Protocol and interface used by each client |
| File transfer | Transfer directions and matching/non-matching SHA-256 hashes |
| Cleanup | Test-file removal, saved-session cleanup, and SSH service state |

The original PDF and exact, unmodified screenshots extracted from it are kept in the local workspace but excluded from Git because they contain personal and machine-identifying information. The source report also describes both host-only and NAT adapters; this lab removes NAT for the exercise. See the [completion report](reports/LAB-3-COMPLETION-REPORT.md).

### Screenshot evidence

The source PDF contains the original screenshots. Exact image files are kept locally in [`screenshots/private/`](screenshots/private/) and are excluded from Git. No mockup or generated screenshots are included in the repository. The supplied PDF shows the MobaXterm start screen, not a connected remote session.

## Safety

- Only use systems you own or are explicitly authorized to administer.
- Do not use bridged networking, scan or probe outside the lab, or expose the SSH service to the internet.
- Use a dedicated lab account and harmless test files; never put passwords, private keys, real logs, or customer data in evidence.
- **Connection refused:** verify the VM is running, the SSH service is active, and the selected address belongs to the host-only interface.
- **Timeout or unreachable host:** verify the host-only adapter is enabled on both sides and that the host and VM use the same host-only network.
- **Host-key warning or changed fingerprint:** stop and verify the VM identity through a trusted channel. Do not accept an unexplained change.
- **Authentication failure:** verify the lab account and authentication method locally; do not test repeated guesses or use another person's credentials.
- Close client sessions and remove saved lab credentials/sessions after use.
- Delete the temporary transfer copies from both systems (keep the repository's sample file) and stop the SSH service:

  ```bash
  sudo systemctl stop ssh
  ```
