#!/usr/bin/env bash
# Lab 03 — Permissions. See README.md.
# Usage: ./solution.sh <dir>
set -euo pipefail
dir="${1:?usage: solution.sh <dir>}"

# TODO 1: tighten <dir>/secrets.env to least-privilege 640 (owner rw, group r, other none).

# TODO 2: print every WORLD-WRITABLE regular file under <dir>, one path per line.
#         hint: find "$dir" -perm -002 -type f
