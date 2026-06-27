#!/usr/bin/env bash
# Lab 02 — File recovery. See README.md.
# Usage: ./solution.sh <dir>
# Find every *.log file under <dir> and copy it into <dir>/recovered/,
# preserving the basename. Existing recovered/ contents are fine to overwrite.
set -euo pipefail
dir="${1:?usage: solution.sh <dir>}"

# TODO 1: create the destination directory "$dir/recovered".
#         hint: mkdir -p "$dir/recovered"

# TODO 2: find every file matching *.log under "$dir" (skip the recovered/ dir
#         itself) and copy each into "$dir/recovered/".
#         hint: find "$dir" -path "$dir/recovered" -prune -o -name '*.log' -type f -print
#               loop over the results and cp each one into "$dir/recovered/".
