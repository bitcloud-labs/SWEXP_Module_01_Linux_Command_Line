# Lab 07 — Dotfiles

**Goal:** build a reproducible shell environment that you install with one command —
the install step is a set of **symlinks** from a versioned `dotfiles/` repo into `$HOME`.

The full lab also writes a `PS1`, aliases, and a function. Here we grade the core of
`install.sh`: **idempotent symlinking.**

## What you do
Complete [`solution.sh`](solution.sh). Given a dotfiles directory and a home
directory, for every file `x` in the dotfiles dir create a symlink at
`<home>/.x` pointing back to the source. Running it twice must succeed and leave
identical links.

```bash
npx bats labs/lab-07-dotfiles/tests
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, open a new shell and prove your aliases/prompt survived, and
  explain why symlinks (not copies) make dotfiles reproducible.

## Submit
Commit and push.
