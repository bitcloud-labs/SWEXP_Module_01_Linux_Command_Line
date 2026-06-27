#!/usr/bin/env bash
# Lab 12 — Packages. See README.md.
# Usage: ./solution.sh <installed-file> <pkg...>
# <installed-file> lists installed package names, one per line.
# For each <pkg> argument, print it (one per line, in the order given) ONLY if
# it is NOT present in the installed list.
set -euo pipefail
installed="${1:?usage: solution.sh <installed-file> <pkg...>}"
shift

# TODO: for each remaining argument, check whether it appears as a whole line
#       in "$installed"; if it does NOT, print the package name.
#       hint: for pkg in "$@"; do
#               grep -qxF "$pkg" "$installed" || printf '%s\n' "$pkg"
#             done
#       (grep -x = whole line match, -F = fixed string, -q = quiet)
