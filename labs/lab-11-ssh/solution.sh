#!/usr/bin/env bash
# Lab 11 — SSH client config. See README.md.
# Usage: ./solution.sh <host> <hostname> <user> <identity>
# Emit a valid ~/.ssh/config block to stdout, e.g.:
#   Host prod
#     HostName 203.0.113.10
#     User deploy
#     IdentityFile ~/.ssh/swexp_ed25519
set -euo pipefail
host="${1:?usage: solution.sh <host> <hostname> <user> <identity>}"
hostname="${2:?usage: solution.sh <host> <hostname> <user> <identity>}"
user="${3:?usage: solution.sh <host> <hostname> <user> <identity>}"
identity="${4:?usage: solution.sh <host> <hostname> <user> <identity>}"

# TODO: print a Host block with four lines: Host, HostName, User, IdentityFile.
#       The Host line starts at column 0; the other three are indented.
#       hint: printf 'Host %s\n  HostName %s\n  User %s\n  IdentityFile %s\n' \
#                    "$host" "$hostname" "$user" "$identity"
