# Lesson 8 — Automate Developer Onboarding

> **Competency:** Bash Scripting & Automation
> **Estimated time:** 3–4 hours

---

## 🎫 Engineering Ticket

```
TICKET:    INFRA-1205
TITLE:     One-command onboarding script for new developer machines
PRIORITY:  P2
DESCRIPTION:
New hires spend a day manually configuring their dev box. Automate it: the
script should create the project directory layout, install required tools
(idempotently), clone repos from a list, validate that prerequisites exist,
and print a clear success/failure summary with exit codes a CI system can
trust. Re-running it must be safe.

ACCEPTANCE CRITERIA:
- A robust Bash script with strict mode and error handling.
- Idempotent: safe to run repeatedly.
- Validates prerequisites and fails loudly with a non-zero exit code.
- Logs actions and prints a final summary.
```

---

## 🎯 Learning Objectives

1. Write Bash scripts with shebangs, arguments, and `set -euo pipefail`.
2. Use variables, conditionals, loops, and functions.
3. Test conditions with `[[ ... ]]`, file tests, and exit codes (`$?`).
4. Make scripts idempotent and defensive.
5. Handle errors with `trap` and meaningful exit codes.

---


## 🧭 Beginner Map

### Big idea
Automation turns a checklist into a repeatable program. A good script is safe to run twice, explains failures clearly, and exits with a code that other tools can trust.

### Key vocabulary
- **Script:** A file of commands run by an interpreter.
- **Shebang:** The first line that chooses the interpreter.
- **Strict mode:** Bash options that make hidden bugs fail loudly.
- **Idempotent:** Safe to run repeatedly with the same final result.
- **Exit code:** A number reporting success or failure to other programs.
- **Trap:** A handler that runs when an error or signal happens.

### Mental model
A script is like a recipe for a robot. If a step fails, the robot should stop and say exactly which ingredient or tool is missing.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Anatomy of a robust script

```bash
#!/usr/bin/env bash
set -euo pipefail        # exit on error, unset var, and pipe failures
IFS=$'\n\t'              # safer word-splitting

log()  { printf '[%s] %s\n' "$(date +%T)" "$*"; }
fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
```

`set -e` exits on any command failure; `set -u` errors on undefined
variables (catches typos); `set -o pipefail` makes a pipeline fail if *any*
stage fails, not just the last. This trio prevents the most common silent
script bugs.

### Conditionals and tests

```bash
if [[ -d "$dir" ]]; then log "exists"; else mkdir -p "$dir"; fi
[[ -f "$file" ]]   # file exists
[[ -x "$bin"  ]]   # executable exists
[[ -z "$var"  ]]   # string empty
[[ "$a" == "$b" ]] # string equality
command -v git >/dev/null || fail "git is required"
```
Use `[[ ]]` (Bash) over `[ ]` (POSIX) — it's safer with spaces and supports
`&&`, `||`, and pattern matching.

### Loops

```bash
for repo in "${REPOS[@]}"; do
  [[ -d "$repo" ]] && { log "skip $repo (exists)"; continue; }
  git clone "https://example.com/$repo.git" || fail "clone $repo failed"
done
```

### Idempotency

An idempotent script produces the same end state whether run once or ten
times. Patterns: `mkdir -p` (no error if exists), check-before-create,
`install` only if `command -v` is missing. This is what separates a toy
script from a production one.

### Traps and exit codes

```bash
trap 'fail "interrupted at line $LINENO"' ERR
```
Return `0` on success, non-zero on failure — CI and other scripts rely on
exit codes to know what happened.

---


## 🔎 Guided Command Reading

Read `set -euo pipefail` as three safety switches: stop on failed commands, stop on missing variables, and stop if any part of a pipeline fails.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Leaving variables unquoted, which breaks paths with spaces.
- Printing an error but still exiting with `0`.
- Writing a script that works once but fails or duplicates work on the second run.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What exact checks make your script idempotent?
- How would CI know your script failed?
- What did ShellCheck catch that your eyes missed?

## 🧪 Hands-on Labs

> See [`labs/lab-08-onboarding-script.md`](labs/lab-08-onboarding-script.md).

**Lab 8.1 — Hello, strict mode**: a script that fails loudly on a bad command.

**Lab 8.2 — Prereq checker** using `command -v` in a loop.

**Lab 8.3 — Idempotent directory + clone** logic.

**Lab 8.4 — Summary + exit codes**: count successes/failures, exit non-zero on any failure.

---

## 📝 Assignment

Write `onboard-dev.sh`: strict mode, prerequisite validation, idempotent
directory/repo setup, logging, and a final summary with correct exit codes.
Run it twice in your notebook to prove idempotency. Commit referencing
`INFRA-1205`.

---

## 🤖 AI Engineering Exercise

Have an AI generate the onboarding script, then run it through `shellcheck`
(`shellcheck onboard-dev.sh`). Record every warning ShellCheck raised that
the AI missed — typically unquoted variables and missing `set -u`. Fix them.
This is the core lesson: AI drafts, tools verify.

---

## 🪞 Reflection

- Which `set` option caught a bug you didn't expect?
- What made your script idempotent — and how did you test it?
- Why do exit codes matter more than printed messages to a machine?

---

## ✅ Definition of Done

- [ ] Script uses `set -euo pipefail` and a `trap`.
- [ ] Prerequisites validated; missing ones fail with non-zero exit.
- [ ] Idempotent (proven by running twice).
- [ ] Passes `shellcheck` with no errors.
