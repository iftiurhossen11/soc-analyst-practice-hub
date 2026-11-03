# Module 04 — Phishing Triage

**Level:** beginner · **Estimated time:** 1–2 hours

## Objectives

- Inspect sender, reply-to, subject, received path, and authentication results.
- Treat links and attachments as untrusted evidence.
- Record indicators without opening links or executing attachments.
- Recommend a proportionate disposition and containment step.

## Lab 1 — Static review only

The complete lab is in [labs/01-static-email-triage](labs/01-static-email-triage/README.md).

Use the fictional message in the lab's `data/sample-email.eml` file. Its domains are reserved examples. Do not click its links or add them to a browser.

**Tasks**

1. Compare `From`, `Reply-To`, and `Return-Path`; note whether a mismatch is conclusive.
2. Record the displayed URL host as text. Do not visit it.
3. Identify the urgency and credential-request language, then list a plausible benign explanation.
4. Draft a user-safe disposition and the evidence you would request from the mail gateway.

Never open unknown attachments on a production endpoint. Use an approved isolated analysis environment and follow organizational policy.
