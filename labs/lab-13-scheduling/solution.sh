#!/usr/bin/env bash
# Lab 13 — Scheduling. See README.md.
# Usage: ./solution.sh <cmd>
# Print a single crontab line that runs <cmd> every weekday at 09:00, i.e. the
# 5-field schedule "0 9 * * 1-5" followed by the command.
set -euo pipefail
cmd="${1:?usage: solution.sh <cmd>}"

# Cron fields:  minute hour day-of-month month day-of-week  command
#               0      9    *             *     1-5          <cmd>
# (day-of-week 1-5 = Monday..Friday)

# TODO: print exactly one line:  0 9 * * 1-5 <cmd>
#       hint: printf '0 9 * * 1-5 %s\n' "$cmd"
