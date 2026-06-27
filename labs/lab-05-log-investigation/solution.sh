#!/usr/bin/env bash
# Lab 05 — Log investigation. See README.md.
# Usage: ./solution.sh <access.log>
# An access log in combined format (field 1 = client IP, field 9 = HTTP status).
# Print exactly two lines:
#   busiest <ip>     # the client IP with the most requests
#   errors <n>       # total number of 4xx + 5xx responses
set -euo pipefail
log="${1:?usage: solution.sh <access.log>}"

# TODO 1: print the busiest client IP:  busiest <ip>
#         hint: awk '{print $1}' "$log" | sort | uniq -c | sort -rn | head -1
#               -> the IP is the second column of that top line.

# TODO 2: print the count of 4xx and 5xx responses:  errors <n>
#         hint: awk '$9 ~ /^[45][0-9][0-9]$/' "$log" | wc -l
