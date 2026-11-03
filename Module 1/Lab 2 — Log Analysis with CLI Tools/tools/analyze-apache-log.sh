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

awk '{print $1}' "$log_file" | sort -u > "$output_dir/unique_ips.txt"
awk '$9 == 404 {print $7}' "$log_file" | sort -u > "$output_dir/not-found-urls.txt"
grep -iE 'nikto|union|select|<script|%3cscript|javascript:|onerror=|\.\./|\.\.%2f' "$log_file" \
    | awk '{print $1}' | sort -u > "$output_dir/suspicious_ips.txt" || true

{
    printf '# Apache Log Analysis Summary\n\n'
    printf -- '- Input: `%s`\n' "$(basename "$log_file")"
    printf -- '- Total requests: %s\n' "$(wc -l < "$log_file")"
    printf -- '- Unique IP addresses: %s\n\n' "$(wc -l < "$output_dir/unique_ips.txt")"
    printf '## Top request sources\n\n```\n'
    awk '{print $1}' "$log_file" | sort | uniq -c | sort -rn | head -10
    printf '```\n\n## Status codes\n\n```\n'
    awk '{print $9}' "$log_file" | sort | uniq -c | sort -rn
    printf '```\n\n## Suspicious request indicators\n\n'
    printf -- '- Nikto requests: %s\n' "$(grep -i 'nikto' "$log_file" | wc -l)"
    printf -- '- SQL-like requests: %s\n' "$(grep -iE 'union|select|insert|update|delete|drop' "$log_file" | wc -l)"
    printf -- '- XSS-like requests: %s\n' "$(grep -iE '<script|%3cscript|javascript:|onerror=' "$log_file" | wc -l)"
    printf -- '- Directory traversal-like requests: %s\n' "$(grep -iE '\.\./|\.\.%2f' "$log_file" | wc -l)"
    printf '\nDo not treat these counts as proof of exploitation or attribution.\n'
} > "$output_dir/analysis-summary.md"

printf 'Wrote analysis artifacts to %s\n' "$output_dir"
