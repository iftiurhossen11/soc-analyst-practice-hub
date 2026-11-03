# Lab 1 — Detection Test Lab

**Module:** 6 · **Level:** intermediate · **Estimated time:** 2–3 hours

Test a small Sigma-style analytic for Windows local account creation against synthetic positive and negative records.

## Contents

- [`rules/local-account-created.yml`](rules/local-account-created.yml)
- [`data/detection-test-events.csv`](data/detection-test-events.csv)
- [`TEST-CASES.md`](TEST-CASES.md)

## Tasks

1. Explain the required source and fields.
2. Confirm one positive and one benign negative test.
3. Design a separate time-bounded correlation with Event ID 4732.
4. Document one tuning change and its approved baseline.

Event ID 4720 alone is an investigation lead, not proof of abuse.
