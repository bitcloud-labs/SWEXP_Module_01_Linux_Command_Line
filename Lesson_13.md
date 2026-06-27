# Lesson 13 — Build an Automated Operations Platform

> **Competency:** Scheduling & Operations Automation
> **Estimated time:** 3–4 hours

---

## 🎫 Engineering Ticket

```
TICKET:    OPS-3500
TITLE:     Automate routine ops: backups, log rotation, and health checks
PRIORITY:  P2
DESCRIPTION:
Routine operations are done manually and inconsistently. Build a small
operations platform: a scheduled nightly backup, automatic log rotation, and
a periodic health check that alerts (writes to a status file / sends a
notification) on failure. Everything must be scheduled, logged, and
observable — no more "did someone run the backup?"

ACCEPTANCE CRITERIA:
- A scheduled, logged nightly backup with retention.
- Log rotation configured so disks don't fill.
- A periodic health check that records pass/fail.
- All jobs observable: you can prove they ran.
```

---

## 🎯 Learning Objectives

1. Schedule jobs with `cron` (and understand the crontab format).
2. Use `systemd` timers as a modern alternative to cron.
3. Configure `logrotate` to manage log growth.
4. Build backup scripts with retention policies.
5. Make scheduled jobs observable (logging, exit codes, status files).

---


## 🧭 Beginner Map

### Big idea
Scheduled operations let the computer do routine work without a person remembering. The job is not complete unless you can prove it ran and see whether it succeeded.

### Key vocabulary
- **cron:** A classic scheduler that runs commands at times you define.
- **systemd timer:** A modern scheduler tied to systemd services.
- **logrotate:** A tool that keeps log files from growing forever.
- **Retention:** A rule for how long backups are kept.
- **Observable:** Easy to prove what happened through logs or status files.

### Mental model
A scheduled job is like an automatic school bell. It must ring at the right time, leave a record that it rang, and have a plan if the bell fails.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### cron: the five-field schedule

```
┌─ minute (0–59)
│ ┌─ hour (0–23)
│ │ ┌─ day of month (1–31)
│ │ │ ┌─ month (1–12)
│ │ │ │ ┌─ day of week (0–7, 0/7 = Sunday)
│ │ │ │ │
* * * * *  command_to_run
```
```bash
crontab -e        # edit your user's jobs
crontab -l        # list them
# 02:30 every night:
30 2 * * *  /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1
```
Always redirect output to a log (`>> ... 2>&1`) — otherwise cron emails it
into the void and you have no record. Cron runs with a **minimal
environment** (tiny PATH, no aliases), so use absolute paths in cron scripts.

### systemd timers (the modern way)

A timer + service pair, more powerful than cron: it logs to the journal,
supports `OnCalendar=`, handles missed runs (`Persistent=true`), and is
observable with `systemctl list-timers`.
```ini
# /etc/systemd/system/backup.timer
[Timer]
OnCalendar=*-*-* 02:30:00
Persistent=true
[Install]
WantedBy=timers.target
```
```bash
systemctl enable --now backup.timer
systemctl list-timers           # when did/will jobs run?
journalctl -u backup.service    # the job's output
```

### logrotate: keep disks from filling

```
# /etc/logrotate.d/myapp
/var/log/myapp/*.log {
    daily
    rotate 14          # keep 14 days
    compress
    missingok
    notifempty
    copytruncate
}
```
Unrotated logs are a classic way to fill `/var` and crash a host (you'll
relive this in Lesson 14).

### Backups with retention

A real backup script: timestamp the archive, write to a backup dir, then
**prune** old backups so they don't accumulate forever.
```bash
tar -czf "/backups/app-$(date +%F).tar.gz" /srv/app
find /backups -name 'app-*.tar.gz' -mtime +14 -delete   # keep 14 days
```

### Observability

A scheduled job nobody can verify is worthless. Make every job: (1) log
start/end with timestamps, (2) exit non-zero on failure, (3) write a status
file (`/var/run/backup.status`) you or a check can read.

---


## 🔎 Guided Command Reading

Read cron left to right: minute, hour, day-of-month, month, day-of-week. Write the English sentence first, then the cron expression.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Forgetting cron has a minimal environment and may not know your PATH.
- Creating backups without deleting old ones.
- Scheduling a job but leaving no logs, so nobody can prove it ran.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What does `30 2 * * *` mean in English?
- Why should cron output be redirected?
- What evidence proves a systemd timer ran?

## 🧪 Hands-on Labs

> See [`labs/lab-13-scheduling.md`](labs/lab-13-scheduling.md).

**Lab 13.1 — A logging cron job** that runs every minute and appends a timestamp.

**Lab 13.2 — Backup script** with timestamped archive + retention prune.

**Lab 13.3 — Convert it to a systemd timer**; confirm via `list-timers`.

**Lab 13.4 — logrotate** a sample log dir and force a rotation with `-f`.

---

## 📝 Assignment

Build the ops platform: a scheduled backup (cron or timer) with retention,
logrotate for an app log dir, and a health check that records pass/fail.
Submit `ops-platform.md` proving each job ran (log excerpts, `list-timers`).
Commit referencing `OPS-3500`.

---

## 🤖 AI Engineering Exercise

Ask an AI for a cron entry to "back up nightly." Verify the five fields
mean what you think (AIs routinely swap day-of-month and day-of-week, or
forget output redirection). Test your final entry's schedule against a cron
expression checker and document the correction.

---

## 🪞 Reflection

- cron vs systemd timers — when would you pick each?
- Why is output redirection essential for a cron job?
- How do you *prove* an unattended job actually ran?

---

## ✅ Definition of Done

- [ ] Scheduled backup with retention, logged.
- [ ] logrotate configured and a rotation demonstrated.
- [ ] Health check records pass/fail.
- [ ] Every job's execution is verifiable.
