# Lab 05 — Log Investigation

**Goal:** turn a raw access log into incident facts using only the command line.

The full lab bounds a 500-spike window and correlates it with an app log. Here we
grade two deterministic facts: **the busiest client and the error volume.**

## What you do
Complete [`solution.sh`](solution.sh). Given an access log in combined format
(field 1 = client IP, field 9 = HTTP status), print exactly two lines:

```
busiest <ip>   # the client IP responsible for the most requests
errors <n>     # total number of 4xx + 5xx responses
```

A fixture lives in [`fixtures/access.log`](fixtures/access.log).

```bash
npx bats labs/lab-05-log-investigation/tests
./solution.sh fixtures/access.log
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, label the fields of one log line and write the incident
  timeline (window, endpoint, root cause).

## Submit
Commit and push.
