#!/usr/bin/env bash
# Lab 01 — Filesystem survey. See README.md.
# Usage: ./solution.sh <dir>
# Survey a directory tree and print three lines, exactly:
#   files <n>
#   dirs <n>
#   largest <basename-of-largest-regular-file>
set -euo pipefail
dir="${1:?usage: solution.sh <dir>}"

# TODO 1: count regular files under "$dir" and print:  files <n>
#         hint: find "$dir" -type f | wc -l

# TODO 2: count directories under "$dir" (excluding "$dir" itself) and print: dirs <n>
#         hint: find "$dir" -mindepth 1 -type d | wc -l

# TODO 3: print the basename of the LARGEST regular file:  largest <name>
#         hint: find "$dir" -type f -printf '%s %p\n' | sort -rn | head -1
#               then take the path (field 2..) and run basename on it.
