# Module 03 — Network Telemetry

**Level:** beginner to intermediate · **Estimated time:** 1–2 hours

## Objectives

- Read a connection record and explain its key fields.
- Build a time-bounded baseline for destinations and services.
- Correlate network observations with an endpoint or identity event.

## Lab 1 — Review synthetic connection records

The complete lab is in [labs/01-network-connection-review](labs/01-network-connection-review/README.md).

The sample records below are fictional and use documentation-only IP addresses.

| Time (UTC) | Source | Destination | Port | Service | State | Analyst note |
|---|---|---|---:|---|---|---|
| 10:00 | 192.0.2.21 | 203.0.113.80 | 443 | ssl | SF | Routine-looking HTTPS baseline |
| 10:03 | 192.0.2.21 | 198.51.100.44 | 443 | ssl | S0 | Repeated short connections; context needed |
| 10:04 | 192.0.2.21 | 198.51.100.44 | 443 | ssl | S0 | Same destination, second observation |
| 10:06 | 192.0.2.21 | 203.0.113.53 | 53 | dns | SF | DNS request; pair with query logs if available |

**Tasks**

1. Group connections by source, destination, port, and time window.
2. List what the connection state does and does not establish.
3. Propose two benign explanations for repeated short connections.
4. Identify the endpoint, DNS, proxy, and change-management evidence needed next.

Do not scan the listed addresses; they are reserved examples, not live targets. A network flow alone does not identify a process or prove malicious intent.
