# Lab 09 — Process Management

**Goal:** find a runaway process by CPU usage — the first step before you decide
which signal to send it.

On a real box you would run `ps aux --sort=-%cpu | head`, then `kill`/`kill -9`.
Here we grade the gradable core: **finding the top-CPU PID in `ps aux` output.**

## What you do
Complete [`solution.sh`](solution.sh). Given a `ps aux`-style table (a header
line, then rows of `USER PID %CPU %MEM ... COMMAND`), print **only** the PID of
the process using the most CPU.

A fixture lives in [`fixtures/ps.txt`](fixtures/ps.txt).

```bash
npx bats labs/lab-09-process-management/tests
./solution.sh fixtures/ps.txt
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, record what happened when you sent SIGTERM before SIGKILL,
  and explain the difference between `start` and `enable`.

## Submit
Commit and push.
