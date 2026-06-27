# Lab 12 — Packages & Supply Chain

**Goal:** inventory installed software and spot what is missing — the basis of a
reproducible, auditable box.

On a real box you would use `apt list --installed`, `dpkg -S`, and a "trusted install"
policy. Here we grade the gradable core: **diffing a wanted set against the installed list.**

## What you do
Complete [`solution.sh`](solution.sh). Given an installed-list file (one package
per line) and a list of wanted packages as arguments, print the wanted packages
that are **missing** from the installed list, one per line, preserving argument
order. Match whole package names only (`vi` must not match `vim`).

A fixture lives in [`fixtures/installed.txt`](fixtures/installed.txt).

```bash
npx bats labs/lab-12-packages/tests
./solution.sh fixtures/installed.txt git tree htop curl
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, write a safer alternative to a `curl | bash` install guide.

## Submit
Commit and push.
