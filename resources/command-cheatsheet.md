# Command Cheat Sheet — SWEXP Module 1

> Quick reference. `man <cmd>` is the authoritative source; verify flags there.

## Orientation (L0–L1)
| Command | Does |
|---------|------|
| `pwd` | print working directory |
| `whoami` / `id` | current user / user+groups |
| `uname -a` | kernel/OS info |
| `ls -lah` | long, all, human sizes |
| `cd -` | jump to previous directory |
| `file X` | identify file type by contents |
| `stat X` | size, perms, timestamps |
| `df -h` / `df -i` | disk space / inodes |
| `du -sh *` | size per item |
| `tree -L 2` | tree view, 2 levels |

## Files & search (L2)
| Command | Does |
|---------|------|
| `mkdir -p a/b/c` | make nested dirs |
| `cp -a src dst` | copy preserving metadata |
| `mv a b` | move/rename |
| `rm -i` | delete, asking first |
| `find . -name '*.py'` | search by name |
| `find . -type f -size +1M` | files over 1 MB |
| `tar -czf x.tgz dir/` | create gzip archive |
| `tar -tzf x.tgz` | list archive (verify) |
| `tar -xzf x.tgz` | extract |

## Permissions & users (L3–L4)
| Command | Does |
|---------|------|
| `chmod 750 f` | set octal perms |
| `chmod u+x,g-w f` | symbolic perms |
| `chown user:grp f` | set owner+group |
| `chmod 2770 dir` | setgid shared dir |
| `useradd -m -s /bin/bash -G grp u` | create user |
| `usermod -aG grp u` | ADD user to group (-a!) |
| `getent group grp` | show group members |
| `visudo -c` | validate sudoers |

## Text & pipelines (L5–L6)
| Command | Does |
|---------|------|
| `grep -in 'x' f` | search, ignore-case, line# |
| `grep -c` / `grep -v` | count / invert |
| `grep -E 're'` | extended regex |
| `awk '{print $7}'` | print a field |
| `awk '$9==500'` | filter by field |
| `cut -d: -f1` | delimited field |
| `sed -n '10,20p'` | print line range |
| `sort \| uniq -c \| sort -rn` | top-N idiom |
| `cmd > f 2>&1` | stdout+stderr to file |
| `cmd \| tee f` | save and pass on |
| `tail -f f` | follow live log |

## Processes & services (L9)
| Command | Does |
|---------|------|
| `ps aux --sort=-%cpu` | top CPU |
| `top` (M = mem) | live monitor |
| `kill PID` / `kill -9 PID` | TERM / KILL |
| `pkill -f pat` | kill by pattern |
| `systemctl status\|start\|restart u` | manage service |
| `systemctl enable --now u` | start + on-boot |
| `journalctl -u u -e` | service logs |

## Networking (L10)
| Command | Does |
|---------|------|
| `ip addr` / `ip route` | interfaces / routes |
| `dig +short host` | resolve name |
| `nc -zv host port` | port reachable? |
| `curl -v URL` | HTTP handshake detail |
| `ss -tlnp` | listening TCP ports + process |

## SSH (L11)
| Command | Does |
|---------|------|
| `ssh-keygen -t ed25519` | make key pair |
| `ssh-copy-id u@host` | install pubkey |
| `scp f host:/path` | copy over SSH |
| `rsync -avz d/ host:/d/` | efficient sync |
| `sshd -t` | validate sshd config |

## Packages (L12)
| Command | Does |
|---------|------|
| `apt update` / `apt upgrade` | refresh meta / install |
| `apt install\|remove --purge` | add / remove+config |
| `dpkg -L pkg` / `dpkg -S file` | files of / owner of |
| `apt list --installed` | inventory |

## Scheduling & resources (L13–L14)
| Command | Does |
|---------|------|
| `crontab -e` / `-l` | edit / list jobs |
| `systemctl list-timers` | scheduled timers |
| `logrotate -d cfg` | dry-run rotation |
| `free -h` | memory (read "available") |
| `lsof +L1` | deleted-but-open files |
