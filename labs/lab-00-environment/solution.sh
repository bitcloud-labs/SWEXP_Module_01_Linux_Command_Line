#!/usr/bin/env bash
# Lab 00 — Environment. See README.md.
# Usage: ./solution.sh <os-release-file>
# Print the value of PRETTY_NAME (without the surrounding quotes) from an
# /etc/os-release-style key=value file.
set -euo pipefail
file="${1:?usage: solution.sh <os-release-file>}"

# TODO: read "$file", find the PRETTY_NAME=... line, and print ONLY the value
#       with the surrounding double quotes stripped.
#       hint: grep '^PRETTY_NAME=' "$file" | cut -d= -f2- | tr -d '"'
