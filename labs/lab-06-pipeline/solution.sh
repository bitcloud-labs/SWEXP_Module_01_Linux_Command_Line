#!/usr/bin/env bash
# Lab 06 — Log processing pipeline. See README.md.
# Usage: ./solution.sh [access.log]   (reads stdin when no file is given)
set -euo pipefail

# Capture input from the file argument, or stdin if none was given:
src="$(cat -- "${1:-/dev/stdin}")"

# TODO 1: print a status-code tally ("<count> <status>", sorted by count desc) to stdout.
#         hint: printf '%s\n' "$src" | awk '{print $9}' | sort | uniq -c | sort -rn

# TODO 2: write every 5xx request line to ./errors.log.
#         hint: printf '%s\n' "$src" | grep -E ' 5[0-9][0-9] ' | tee errors.log >/dev/null
