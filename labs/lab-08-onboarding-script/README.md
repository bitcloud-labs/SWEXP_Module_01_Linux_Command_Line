# Lab 08 — Onboarding Script

**Goal:** write a robust, **idempotent** Bash script with a prerequisite check.

## What you do
Complete [`solution.sh`](solution.sh). Given a target directory, it must:

1. **Fail** (exit non-zero, message to stderr) if any command listed in `$REQUIRE`
   (default `git bash`) is missing — hint: `command -v "$c"`.
2. **Idempotently** create `<target>/projects` and a `<target>/.onboarded` marker.
   Running it twice must succeed and leave the same state (use `mkdir -p`, guard the marker).

```bash
npx bats labs/lab-08-onboarding-script/tests
```

## Definition of done
- Tests green; `npm run check` clean. In your LMS notebook, prove idempotency by running it
  twice and comparing the resulting state (and run ShellCheck if you have it).

## Submit
Commit and push.
