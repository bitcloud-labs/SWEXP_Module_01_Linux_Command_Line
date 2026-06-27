# Lab 00 — Environment

**Goal:** identify the box you are on by parsing `/etc/os-release` — the file every
distro ships so tools (and humans) can tell which OS they are running on.

In the LMS box you would provision a real Ubuntu instance and run
`whoami; pwd; id; uname -a; cat /etc/os-release`. Here we grade the one
machine-checkable core: **reading a key=value file and extracting a value.**

## What you do
Complete [`solution.sh`](solution.sh). It takes the path to an `os-release`-style
file and must:

1. Find the `PRETTY_NAME=...` line.
2. Print **only** its value, with the surrounding double quotes stripped
   (e.g. `Ubuntu 24.04.1 LTS`).

A sample file lives in [`fixtures/os-release`](fixtures/os-release).

```bash
npx bats labs/lab-00-environment/tests
./solution.sh fixtures/os-release
```

## Definition of done
- `npm test` for this lab is green; `npm run check` (shell syntax) is clean.
- In your LMS notebook, record the output of `whoami; id; uname -a` on your real box
  and explain what `PRETTY_NAME` is used for.

## Submit
Commit and push. The autograder scores it automatically.
