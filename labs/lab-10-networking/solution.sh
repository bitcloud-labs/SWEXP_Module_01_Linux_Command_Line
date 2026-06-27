#!/usr/bin/env bash
# Lab 10 — Networking. See README.md.
# Usage: ./solution.sh <ss-file>
# Output of `ss -ltn` (header line, then LISTEN rows). Field 4 is the local
# socket "Address:Port". Print the unique listening ports, one per line,
# sorted numerically ascending.
set -euo pipefail
file="${1:?usage: solution.sh <ss-file>}"

# TODO: skip the header, take field 4 (Local Address:Port), keep only the part
#       after the LAST colon (the port), de-duplicate, and sort numerically.
#       hint: tail -n +2 "$file" | awk '{print $4}' | sed 's/.*://' | sort -n | uniq
