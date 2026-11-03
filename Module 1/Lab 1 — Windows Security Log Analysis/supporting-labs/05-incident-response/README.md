# Module 05 — Incident Response and Case Handling

**Level:** intermediate · **Estimated time:** 1–2 hours

## Objectives

- Preserve scope and evidence provenance.
- Build a UTC-normalized timeline from multiple sources.
- Separate observed facts, inferences, and unknowns.
- Recommend containment and recovery actions that require the system owner's approval.

## Lab 1 — Build a case timeline

The complete lab is in [labs/01-case-timeline](labs/01-case-timeline/README.md).

Use only the synthetic events in Module 1. Create a timeline with these columns:

`timestamp_utc | source | event | account/asset | observed fact | interpretation | confidence`

**Tasks**

1. Order the failed logons, successful logon, explicit-credential event, and group-change event.
2. Identify which records may share a user or host and which cannot safely be correlated.
3. Write an executive summary that distinguishes confirmed observations from hypotheses.
4. Propose immediate evidence-preservation steps and owner-approved containment options.
5. List the evidence needed to close or escalate the case.

Do not isolate, disable, delete, or modify any real account or system as part of this exercise.
