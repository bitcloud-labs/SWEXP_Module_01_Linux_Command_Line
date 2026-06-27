#!/usr/bin/env bash
# Lab 07 — Dotfiles install. See README.md.
# Usage: ./solution.sh <dotfiles-dir> <home-dir>
# For every regular file named "x" in <dotfiles-dir>, create a symlink at
# <home-dir>/.x that points back to the source file. Must be IDEMPOTENT:
# running it a second time succeeds and leaves the same links.
set -euo pipefail
src="${1:?usage: solution.sh <dotfiles-dir> <home-dir>}"
home="${2:?usage: solution.sh <dotfiles-dir> <home-dir>}"

# TODO 1: ensure "$home" exists.            hint: mkdir -p "$home"

# TODO 2: for each regular file in "$src", symlink it to "$home/.<basename>".
#         Use an idempotent, force flag so a second run does not error.
#         hint: ln -sfn "$src/$name" "$home/.$name"
#         (ln -s = symlink, -f = replace existing, -n = treat existing link as a file)
