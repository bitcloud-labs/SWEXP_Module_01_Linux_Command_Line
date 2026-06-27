# Lab 03 — Permissions

**Goal:** fix a "too open" secret to least privilege, and surface world-writable files — no `chmod 777`.

## What you do
Complete [`solution.sh`](solution.sh). It takes a directory and must:

1. Tighten `<dir>/secrets.env` to **640** (owner rw, group r, other none).
2. Print every **world-writable** regular file under `<dir>`, one path per line (hint: `find … -perm -002 -type f`).

Run the tests:
```bash
npx bats labs/lab-03-permissions/tests
# or everything: npm test
```

## Definition of done
- `npm test` for this lab is green; `npm run check` (shell syntax) is clean.
- In your LMS notebook, explain why `640` (not `777`), and decode a few `ls -l` strings.

## Submit
Commit and push. The autograder scores it automatically.
