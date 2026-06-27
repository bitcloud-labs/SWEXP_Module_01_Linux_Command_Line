#!/usr/bin/env bash
# Lab 09 — Process management. See README.md.
# Usage: ./solution.sh <ps-file>
# A `ps aux`-style table (header line, then USER PID %CPU %MEM ... COMMAND).
# Print ONLY the PID of the process using the most CPU.
set -euo pipefail
file="${1:?usage: solution.sh <ps-file>}"

# TODO: skip the header line, sort the remaining rows by %CPU (field 3)
#       descending, and print the PID (field 2) of the top row.
#       hint: tail -n +2 "$file" | sort -k3 -rn | head -1 | awk '{print $2}'
