# Lab 02 — File Recovery

**Goal:** rebuild a scattered project by finding files that match a pattern and
collecting them in one place.

The full lab rebuilds a conventional `src/config/docs` tree and archives it. Here
we grade the gradable core: **`find` by pattern, then copy.**

## What you do
Complete [`solution.sh`](solution.sh). Given a directory, it must:

1. Create `<dir>/recovered/`.
2. Find every `*.log` file under `<dir>` and copy each into `<dir>/recovered/`
   (do not copy non-log files; do not descend back into `recovered/`).

```bash
npx bats labs/lab-02-file-recovery/tests
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, explain why you **preview** a `find` before you `cp`/`rm`, and
  prove a duplicate with `md5sum`.

## Submit
Commit and push.
