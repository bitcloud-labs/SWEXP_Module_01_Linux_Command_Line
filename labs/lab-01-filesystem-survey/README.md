# Lab 01 — Filesystem Survey

**Goal:** map an unfamiliar tree read-only and report findings — the first thing you
do on any unknown box.

On the real box you would run `ls -lah /`, `df -h`, and `du -sh /var/* | sort -rh`.
Here we grade the gradable core: **counting and ranking files in a tree.**

## What you do
Complete [`solution.sh`](solution.sh). Given a directory, it must print exactly
three lines:

```
files <n>      # number of regular files under <dir>
dirs <n>       # number of sub-directories under <dir>
largest <name> # basename of the largest regular file
```

The test builds a known tree in a temp dir, so your counts must be exact.

```bash
npx bats labs/lab-01-filesystem-survey/tests
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, paste a real `du -sh /var/* | sort -rh | head` and explain the
  three largest directories.

## Submit
Commit and push.
