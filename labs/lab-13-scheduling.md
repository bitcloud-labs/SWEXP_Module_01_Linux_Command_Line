# Lab 13 — Scheduling (Lesson 13)

## Goal
Schedule a backup with retention; rotate logs; make jobs observable.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Translate the cron schedule into English before installing it.
- Look for proof that a scheduled job ran, not just that it was configured.
- Challenge: intentionally dry-run logrotate and explain what it would do.

## Tasks
1. **A logging cron job (every minute, then remove it):**
   ```bash
   ( crontab -l 2>/dev/null; echo '* * * * * date >> /tmp/cron-demo.log 2>&1' ) | crontab -
   sleep 65; cat /tmp/cron-demo.log
   crontab -l | grep -v cron-demo | crontab -    # clean up
   ```
2. **Backup script with retention:**
   ```bash
   mkdir -p ~/swexp-lab/l13/{src,backups}; echo data > ~/swexp-lab/l13/src/file
   tar -czf ~/swexp-lab/l13/backups/app-$(date +%F).tar.gz -C ~/swexp-lab/l13 src
   find ~/swexp-lab/l13/backups -name 'app-*.tar.gz' -mtime +14 -delete
   ```
3. **systemd timer (if available):** create `backup.timer` + `backup.service`,
   `systemctl enable --now backup.timer`, then `systemctl list-timers`.
4. **logrotate dry run:** write `/etc/logrotate.d/swexp-demo` and
   `sudo logrotate -d /etc/logrotate.d/swexp-demo` (debug, no changes).

## Deliverable
`ops-platform.md` proving each job ran. Solution:
[`../solutions/lab-13-solution.md`](../solutions/lab-13-solution.md).
