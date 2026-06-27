# Lab 06 — Log Processing Pipeline

**Goal:** turn a raw access log into a deterministic report and tee the 5xx lines aside.

## What you do
Complete [`solution.sh`](solution.sh). Given an access log (a file argument **or** stdin), it must:

1. Print a status-code tally — lines of `<count> <status>` sorted by count, descending
   (hint: `awk '{print $9}' | sort | uniq -c | sort -rn`).
2. Write every **5xx** request line to `./errors.log` (hint: `grep -E ' 5[0-9][0-9] ' | tee errors.log`).

It must work both ways:
```bash
npx bats labs/lab-06-pipeline/tests
./solution.sh fixtures/access.log
cat fixtures/access.log | ./solution.sh
```

## Definition of done
- Tests green; `npm run check` clean. The report is identical from file or stdin.

## Submit
Commit and push.
