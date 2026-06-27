# Troubleshooting Playbook

Layered, reproducible recipes. The meta-rule: **isolate the layer, gather
evidence, change one thing at a time, verify.**

## "Disk is full"
1. `df -h` — which filesystem? (`/`, `/var`?)
2. `df -i` — is it actually **inodes**, not space?
3. `du -xh / 2>/dev/null | sort -rh | head` — biggest dirs on that fs.
4. `find /var/log -type f -size +100M` — giant logs (usual culprit).
5. `lsof +L1` — **deleted-but-open** files holding space; restart the holder.
6. Recover: rotate/truncate logs, `apt clean`, prune backups. **Never** delete
   what you can't identify.

## "Out of memory / OOM killer fired"
1. `free -h` — read **available**, not "free".
2. `ps aux --sort=-%mem | head` — the hog.
3. `journalctl -k | grep -i oom` — what got killed and when.
4. Stop the offender / fix the leak; swap is a stopgap, not a fix.

## "Service won't stay up"
1. `systemctl status <unit>` — Active state + exit code + last lines.
2. `journalctl -u <unit> -e` — the crash reason.
3. Distinguish *crashing* (fix cause) from *not set to restart* (`Restart=on-failure`).
4. Restore: `systemctl enable --now <unit>`; confirm it survives a restart.

## "Can't connect to X"
Walk the layers, stop at the first failure:
1. `ip addr` interface up? → 2. `ip route` path? → 3. `dig host` resolves? →
4. `nc -zv host port` reachable? → 5. `ss -tlnp` on the target listening? →
6. firewall (`ufw status` / `iptables -L`) allowing it?
Most common: DNS, firewall, service down, or bound only to `127.0.0.1`.

## "Permission denied"
1. `ls -l` / `ls -ld` the target — owner, group, mode.
2. `id` — am I in the right group? On a dir, do I have `x` to traverse?
3. Fix with correct `chown`/`chmod` and **least privilege** — never `777`.

## "My script silently did the wrong thing"
1. Add `set -euo pipefail`. 2. `shellcheck` it. 3. Quote all `"$vars"`.
4. Dry-run any `find`/`rm`/`mv` with destructive actions removed first.
