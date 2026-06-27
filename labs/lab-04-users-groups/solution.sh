#!/usr/bin/env bash
# Lab 04 — Users & groups. See README.md.
# Usage: ./solution.sh <group> <group-file>
# Print the members of <group>, one per line, parsed from a getent/`/etc/group`
# style file:  name:passwd:gid:member1,member2,member3
# Print nothing (exit 0) if the group exists but has no members.
set -euo pipefail
group="${1:?usage: solution.sh <group> <group-file>}"
file="${2:?usage: solution.sh <group> <group-file>}"

# TODO: find the line whose first colon-field equals "$group", take the 4th
#       field (the comma-separated member list), and print each member on its
#       own line.
#       hint: awk -F: -v g="$group" '$1==g {print $4}' "$file" | tr ',' '\n' | sed '/^$/d'
