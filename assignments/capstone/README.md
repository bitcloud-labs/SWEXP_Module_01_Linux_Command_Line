# Capstone — CAP-9000 (gradable core)

**Goal:** integrate three Module-01 skills into one **server health check** that a
teammate could run on a fresh box.

The full capstone (`../capstone-brief.md`) is an 8–12 hour engagement: an idempotent
`provision.sh`, a systemd demo service, hardened SSH, an operations layer, dotfiles,
and full docs — all done in the LMS code-server and tagged `v1.0-capstone`. Here we
grade the gradable core that ties the labs together: **one script that audits a box's
state and reports problems.**

## What you do
Complete [`solution.sh`](solution.sh). Given a directory `<dir>` containing:

- files/subdirs to audit,
- `df.txt` — `df -P` output,
- `installed.txt` — installed packages (one per line),
- `wanted.txt` — required packages (one per line),
- `threshold` — an integer use% (e.g. `80`),

print a report with these three sections (combining lab-03, lab-14, and lab-12):

```
== WORLD-WRITABLE ==
  <world-writable files under <dir>>
== DISK OVER THRESHOLD ==
  <mount points in df.txt over the threshold>
== MISSING PACKAGES ==
  <packages in wanted.txt not in installed.txt>
```

A ready-to-run sample lives in [`fixtures/`](fixtures/) (copy them into a dir and run).

```bash
npx bats assignments/capstone/tests
```

## Definition of done
- `npm test` for the capstone is green; `npm run check` is clean.
- Then complete the full CAP-9000 deliverables in your LMS box and fill in
  [`../capstone-submission-template.md`](../capstone-submission-template.md).

## Submit
Commit and push. The autograder scores this core; the full capstone is reviewed in the LMS.
