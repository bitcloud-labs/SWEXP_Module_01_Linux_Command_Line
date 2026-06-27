# Lab 14 — Out of Resources

**Goal:** spot filesystems that are about to fill up — before they take a service down.

The full lab simulates disk/inode/memory pressure and the deleted-but-open trap. Here
we grade the gradable core: **flagging over-threshold filesystems from `df` output.**

## What you do
Complete [`solution.sh`](solution.sh). Given `df -P` output and an integer
threshold, print the **mount point** of every filesystem whose use% is strictly
greater than the threshold, one per line, in the order they appear.

A fixture lives in [`fixtures/df.txt`](fixtures/df.txt).

```bash
npx bats labs/lab-14-resources/tests
./solution.sh fixtures/df.txt 80
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, explain the deleted-but-open trap (why `rm` may not free space)
  and one guardrail you would add to catch a filling disk early.

## Submit
Commit and push.
