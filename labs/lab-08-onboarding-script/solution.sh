#!/usr/bin/env bash
# Lab 08 — Idempotent onboarding script. See README.md.
# Usage: ./solution.sh <target-dir>
# Env:   REQUIRE="git bash"   (space-separated required commands)
set -euo pipefail
target="${1:?usage: solution.sh <target-dir>}"
REQUIRE="${REQUIRE:-git bash}"

log()  { printf '[%s] %s\n' "$(date +%T)" "$*"; }
fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

# TODO 1: for each command in $REQUIRE, fail() if it is not available.

# TODO 2: idempotently create "$target/projects" and the marker "$target/.onboarded".
