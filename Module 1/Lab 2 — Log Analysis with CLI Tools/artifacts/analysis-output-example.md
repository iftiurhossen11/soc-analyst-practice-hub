# CLI Analysis Output Example

This is a captured text result from running `tools/analyze-apache-log.sh` against the repository's synthetic `data/apache-access.log`. It is provided as a reproducible alternative to a terminal screenshot.

```text
# Apache Log Analysis Summary

- Input: `apache-access.log`
- Total requests: 13
- Unique IP addresses: 4

## Top request sources

      6 203.0.113.44
      3 198.51.100.24
      3 192.0.2.10
      1 198.51.100.60

## Status codes

      5 200
      3 404
      3 400
      2 401

## Suspicious request indicators

- Nikto requests: 3
- SQL-like requests: 1
- XSS-like requests: 1
- Directory traversal-like requests: 1
```

The addresses are documentation-only examples. The indicator counts are investigative leads, not proof of exploitation or attribution.
