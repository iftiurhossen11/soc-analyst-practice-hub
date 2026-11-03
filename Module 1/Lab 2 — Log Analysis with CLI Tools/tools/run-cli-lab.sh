#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
    printf 'Usage: %s <access-log> <output-directory>\n' "$0" >&2
    exit 2
fi

log_file=$1
output_dir=$2

if [[ ! -f "$log_file" ]]; then
    printf 'Input log not found: %s\n' "$log_file" >&2
    exit 1
fi

mkdir -p "$output_dir"

{
    printf '# CLI Lab Execution Report\n\n'
    printf -- '- Input: `%s`\n' "$(basename "$log_file")"
    printf -- '- Generated: %s UTC\n\n' "$(date -u '+%Y-%m-%d %H:%M:%S')"

    printf '## Apache format sample\n\n```text\n'
    head -n 5 "$log_file"
    printf '```\n\n## Basic counts\n\n'
    printf -- '- Total requests: %s\n' "$(wc -l < "$log_file")"
    printf -- '- Unique IP addresses: %s\n\n' "$(awk '{print $1}' "$log_file" | sort -u | wc -l)"

    printf '### Top talkers\n\n```text\n'
    awk '{print $1}' "$log_file" | sort | uniq -c | sort -rn | head -10
    printf '```\n\n## HTTP status codes\n\n```text\n'
    awk '{print $9}' "$log_file" | sort | uniq -c | sort -rn
    printf '```\n\n'
    printf -- '- 404 requests: %s\n\n' "$(awk '$9 == 404' "$log_file" | wc -l)"

    printf '### Top 404 paths\n\n```text\n'
    awk '$9 == 404 {print $7}' "$log_file" | sort | uniq -c | sort -rn | head -5
    printf '```\n\n## Scanner activity\n\n'
    printf -- '- Nikto requests: %s\n' "$(grep -i 'nikto' "$log_file" | wc -l)"
    printf '```text\n'
    grep -i 'nikto' "$log_file" | head -5 || true
    printf '```\n\n## SQL-like requests\n\n```text\n'
    grep -iE 'union|select|insert|update|delete|drop|exec|%27|%20union|%20select' "$log_file" || true
    printf '```\n\n## XSS-like requests\n\n```text\n'
    grep -iE '<script|javascript:|onerror=|%3cscript' "$log_file" || true
    printf '```\n\n## Directory-traversal-like requests\n\n```text\n'
    grep -iE '\.\./|\.\.%2[fF]' "$log_file" || true
    printf '```\n\n## Traffic by hour\n\n```text\n'
    awk '{gsub(/\[/, "", $4); split($4, time, ":"); print time[2]}' "$log_file" | sort | uniq -c | sort -rn
    printf '```\n\n## HTTP methods\n\n```text\n'
    awk '{print $6}' "$log_file" | tr -d '"' | sort | uniq -c | sort -rn
    printf '```\n\n## Sed and cut demonstrations\n\n```text\n'
    printf '$ sed -E '\''s/\\].*//'\'\'' data/apache-access.log | head -2\n'
    sed -E 's/\].*//' "$log_file" | head -2
    printf '$ cut -d '\'' '\'' -f1,7 data/apache-access.log | head -5\n'
    cut -d ' ' -f1,7 "$log_file" | head -5
    printf '```\n\n## Anonymized sources\n\n```text\n'
    awk '{split($1, octet, "."); print octet[1] "." octet[2] "." octet[3] ".x"}' "$log_file" | sort -u
    printf '```\n\n'
    printf 'Suspicious patterns are leads for correlation, not proof of exploitation, compromise, or attribution.\n'
} > "$output_dir/cli-lab-execution-report.md"

printf 'Wrote CLI lab report to %s\n' "$output_dir/cli-lab-execution-report.md"
