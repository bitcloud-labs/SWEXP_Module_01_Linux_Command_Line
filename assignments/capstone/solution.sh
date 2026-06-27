#!/usr/bin/env bash
# Capstone (CAP-9000 core) — Server health check. See README.md.
# Usage: ./solution.sh <dir>
#
# Integrates three Module-01 cores into one report. <dir> contains:
#   - any files/subdirs to audit for world-writable permissions
#   - df.txt        : `df -P` output            (threshold check)
#   - installed.txt : installed packages, 1/line
#   - wanted.txt    : required packages, 1/line  (missing check)
#   - threshold     : a single integer use% (e.g. 80)
#
# Print a report with these three section headers, EXACTLY, each followed by
# zero or more indented findings:
#
#   == WORLD-WRITABLE ==
#     <path>            # every world-writable regular file under <dir>
#   == DISK OVER THRESHOLD ==
#     <mount>           # every filesystem in df.txt whose use% > threshold
#   == MISSING PACKAGES ==
#     <pkg>             # every package in wanted.txt absent from installed.txt
set -euo pipefail
dir="${1:?usage: solution.sh <dir>}"

threshold="$(cat "$dir/threshold")"

# TODO 1: print the line:  == WORLD-WRITABLE ==
#         then, indented by two spaces, every world-writable regular file under
#         "$dir" (find "$dir" -perm -002 -type f). Skip the control files
#         (df.txt, installed.txt, wanted.txt, threshold) is NOT required — the
#         tests only make real data files world-writable.

# TODO 2: print the line:  == DISK OVER THRESHOLD ==
#         then, indented by two spaces, the mount point of each filesystem in
#         "$dir/df.txt" whose use% (field 5, strip '%') is > "$threshold"
#         (reuse your lab-14 logic).

# TODO 3: print the line:  == MISSING PACKAGES ==
#         then, indented by two spaces, each package in "$dir/wanted.txt" that
#         does NOT appear as a whole line in "$dir/installed.txt"
#         (reuse your lab-12 logic).
