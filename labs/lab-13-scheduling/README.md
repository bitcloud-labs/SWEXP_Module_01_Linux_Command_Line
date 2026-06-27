# Lab 13 — Scheduling

**Goal:** write a correct cron schedule — the five-field expression is where most
scheduling bugs live.

The full lab installs cron jobs, a backup with retention, and a logrotate dry run.
Here we grade the gradable core: **producing the exact schedule expression.**

## What you do
Complete [`solution.sh`](solution.sh). Given a command, print a single crontab
line that runs it **every weekday at 09:00**:

```
0 9 * * 1-5 <cmd>
```

(minute=0, hour=9, any day-of-month, any month, day-of-week 1-5 = Mon–Fri.)

```bash
npx bats labs/lab-13-scheduling/tests
./solution.sh '/usr/local/bin/backup.sh'
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, translate the schedule into plain English and describe how
  you would *prove* a scheduled job actually ran.

## Submit
Commit and push.
