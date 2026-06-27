# Lab 10 — Networking

**Goal:** audit which TCP ports a host is listening on — the core of any exposure review.

On a real box you would walk DNS → route → port → HTTP and run `ss -tlnp`. Here we
grade the gradable core: **extracting the listening ports from `ss` output.**

## What you do
Complete [`solution.sh`](solution.sh). Given the output of `ss -ltn` (a header
line, then `LISTEN` rows whose 4th field is `Address:Port`), print the **unique**
listening ports, one per line, **sorted numerically ascending**.

A fixture lives in [`fixtures/ss.txt`](fixtures/ss.txt).

```bash
npx bats labs/lab-10-networking/tests
./solution.sh fixtures/ss.txt
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, explain why a service bound to `127.0.0.1` is safer than one
  bound to `0.0.0.0`, using a port from the fixture as an example.

## Submit
Commit and push.
