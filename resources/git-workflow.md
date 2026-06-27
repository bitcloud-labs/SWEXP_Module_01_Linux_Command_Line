# Git Workflow for SWEXP

Your Git history is part of how you are assessed. Treat commits as engineering
communication, not save points.

## Commit messages
Reference the ticket and say *what* and *why*:
```
INFRA-1120: add idempotent payments onboarding script

Uses usermod -aG (not -G) to avoid clobbering existing groups.
Guards each step so re-runs are safe.
```
- Subject ≤ ~50 chars, imperative mood, ticket prefix.
- Body explains reasoning and tradeoffs when non-obvious.

## Branching (per ticket)
```bash
git switch -c feat/INFRA-1120-onboarding
# ...work, commit in small logical steps...
git switch main && git merge --no-ff feat/INFRA-1120-onboarding
```

## What to commit / not commit
- **Commit:** scripts, configs (sanitized), docs, notebook, lab deliverables.
- **Never commit:** secrets, private keys, passwords, real customer data.
  Add a `.gitignore` for `*.env`, `id_*`, `*.key`.

## Useful habits
```bash
git status         # before every commit
git diff --staged  # review exactly what you're committing
git log --oneline --graph   # tell the story of your work
git tag v1.0-capstone       # tag your capstone release
```

## The standard for "done"
A teammate should be able to clone your repo, read the README, and reproduce
your work without asking you anything.
