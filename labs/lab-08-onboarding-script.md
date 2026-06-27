# Lab 08 — Onboarding Script (Lesson 8)

## Goal
Write a robust, idempotent Bash script and verify it with ShellCheck.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict which line will fail if a required command is missing.
- Run the script twice and compare the final state, not just the printed messages.
- Challenge: deliberately break one prerequisite and confirm the script exits non-zero.

## Tasks
1. **Strict-mode skeleton:**
   ```bash
   cat > onboard-dev.sh <<'SH'
   #!/usr/bin/env bash
   set -euo pipefail
   log(){ printf '[%s] %s\n' "$(date +%T)" "$*"; }
   fail(){ printf 'ERROR: %s\n' "$*" >&2; exit 1; }
   SH
   ```
2. **Prereq check:** `for c in git curl; do command -v "$c" >/dev/null || fail "$c missing"; done`
3. **Idempotent setup:** `mkdir -p "$HOME/projects"` and clone-only-if-absent logic.
4. **Summary + exit code:** track failures, `exit 1` if any.
5. **Verify:** `shellcheck onboard-dev.sh` — fix every warning. Run twice to prove idempotency.

## Deliverable
A `shellcheck`-clean, idempotent `onboard-dev.sh`. Solution:
[`../solutions/lab-08-solution.md`](../solutions/lab-08-solution.md).
