# Module 07 — Threat Intelligence

**Level:** beginner to intermediate · **Estimated time:** 1–2 hours

## Objectives

- Separate an observable from an assessed indicator.
- Record source, time, confidence, and expiration for intelligence.
- Avoid treating a match as proof of malicious activity.
- Preserve privacy when enriching data.

## Lab 1 — IOC context worksheet

The complete lab is in [labs/01-ioc-context](labs/01-ioc-context/README.md).

The values below are reserved documentation addresses and must not be queried as real indicators:

| Observable | Context |
|---|---|
| `203.0.113.80` | Documentation-only IPv4 address |
| `training.example.net` | Reserved example domain |
| `sha256:0000000000000000000000000000000000000000000000000000000000000000` | Placeholder, not a file hash |

For each value, complete:

`observable | type | source | first_seen | last_seen | confidence | business context | expiration | action`

**Tasks**

1. Explain why the examples cannot support a real block decision.
2. List two benign reasons an IOC could match.
3. Describe what you would verify before sharing an indicator with another team.
4. Recommend a confidence level and expiration policy for a real, authorized case.

Do not upload private files, URLs, or customer data to public reputation services.
