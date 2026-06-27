#!/usr/bin/env bash
# Lab 14 — Out of resources. See README.md.
# Usage: ./solution.sh <df-file> <threshold>
# <df-file> is `df -P` output (header, then rows). Field 5 is the use% capacity
# (e.g. "92%"); field 6 is the mount point. Print the MOUNT POINT of every
# filesystem whose use% is STRICTLY GREATER than <threshold> (an integer),
# one per line, in the order they appear.
set -euo pipefail
file="${1:?usage: solution.sh <df-file> <threshold>}"
threshold="${2:?usage: solution.sh <df-file> <threshold>}"

# TODO: skip the header line; for each row strip the '%' from field 5, and if
#       that number is greater than "$threshold", print field 6 (the mount point).
#       hint: awk -v t="$threshold" 'NR>1 { pct=$5; sub(/%/,"",pct); if (pct+0 > t) print $6 }' "$file"
