# Lesson 14 — Diagnose a Production Server Running Out of Resources

> **Competency:** Storage, Memory & Observability
> **Estimated time:** 3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    OPS-3600
TITLE:     Server alerting "disk full" and "out of memory" — recover it
PRIORITY:  P0 (host degraded)
DESCRIPTION:
Monitoring is screaming: the root filesystem is at 98% and the OOM killer
has started terminating processes. Writes are failing. Find what's eating
disk and memory, recover safely without destroying data we need, and put a
guardrail in place so this doesn't recur. This is a live-fire diagnosis.

ACCEPTANCE CRITERIA:
- Identify what filled the disk and what consumed memory.
- Recover free space and stabilize memory safely.
- Confirm the host is healthy (df, free, no OOM events).
- A guardrail (alert/rotation/quota) to prevent recurrence.
```

---

## 🎯 Learning Objectives

1. Diagnose disk usage with `df`, `du`, and find large/old files.
2. Distinguish "disk full" from "inodes full."
3. Diagnose memory with `free`, `top`, and understand swap and the OOM killer.
4. Read the journal for OOM and disk-full events.
5. Recover safely and add a preventive guardrail.

---


## 🧭 Beginner Map

### Big idea
Resource troubleshooting asks what the machine is running out of: disk blocks, inodes, memory, or swap. Recovery must protect data, not just delete things quickly.

### Key vocabulary
- **Block usage:** How much disk space is used.
- **Inode:** A filesystem record for a file; too many tiny files can exhaust them.
- **Deleted-but-open file:** A removed file still held by a running process.
- **Available memory:** Memory Linux can give to programs if needed.
- **OOM killer:** Kernel feature that kills a process when memory is exhausted.
- **Guardrail:** A prevention mechanism such as rotation, alerts, quotas, or limits.

### Mental model
A server is like a classroom with desks and storage bins. You can run out of floor space, run out of labels for bins, or have one project using all the desks. Each shortage needs a different fix.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Disk: where did it all go?

```bash
df -h                              # per-filesystem usage — find the full one
df -i                              # INODES — a dir of millions of tiny files
                                   #   can exhaust inodes with df -h at 40%
du -xh / 2>/dev/null | sort -rh | head -20   # biggest dirs on root fs (-x stays on one fs)
find /var/log -type f -size +100M  # giant log files (the usual culprit)
```
Two distinct "full" conditions: **blocks** (real space, `df -h`) and
**inodes** (file *count*, `df -i`). A surprise inode exhaustion looks like
"disk full" while `df -h` shows space free.

**Deleted-but-open trap:** if you `rm` a huge log a process still has open,
the space is *not* freed until the process closes it. Find it with
`lsof +L1` (files with link count 0 still held open), then restart/signal
the holder.

### Memory and the OOM killer

```bash
free -h                            # used/free/available/swap
top                                # press M to sort by memory
ps aux --sort=-%mem | head
```
Linux uses free RAM for cache (that's healthy — look at **available**, not
"free"). When memory truly runs out and there's no swap headroom, the
kernel's **OOM killer** terminates the process with the worst "badness"
score. You'll see it in the journal:
```bash
journalctl -k | grep -i "out of memory\|oom"
dmesg | grep -i oom
```

### Recover safely

- Free disk: rotate/compress/truncate logs (`truncate -s 0 huge.log` if a
  process holds it), clear `/tmp`, `apt clean`, prune old backups — never
  blindly delete files you can't identify.
- Memory: stop the offending process, add/enable swap as a stopgap, fix the
  leak. Adding swap buys time but doesn't fix a leak.

### Guardrails

logrotate (Lesson 13), disk-usage alerts, `MemoryMax=` in a systemd unit to
cap a service, and filesystem quotas all prevent recurrence. The postmortem
must end with a guardrail, not just a cleanup.

---


## 🔎 Guided Command Reading

Use evidence before cleanup: `df -h` for space, `df -i` for inodes, `du` for directory sizes, `lsof +L1` for deleted-open files, and `free -h` for memory.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Deleting files you cannot identify.
- Missing deleted-but-open files and wondering why space did not return.
- Panicking at low `free` memory instead of reading `available`.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- How can a disk be full when `df -h` shows space free?
- Why might `rm huge.log` not immediately free space?
- What guardrail would prevent the same incident next time?

## 🧪 Hands-on Labs

> See [`labs/lab-14-resources.md`](labs/lab-14-resources.md); it safely fills a
> scratch directory and spawns a memory hog you can kill.

**Lab 14.1 — Disk hunt**: fill a scratch dir, find it with `du | sort -rh`, reclaim it.

**Lab 14.2 — Inode demo**: create thousands of empty files, watch `df -i` climb.

**Lab 14.3 — Deleted-but-open**: hold a file open, `rm` it, see space not freed, fix with the holder.

**Lab 14.4 — Memory + OOM**: run a bounded memory hog, observe `free`, find the OOM line in the journal.

---

## 📝 Assignment

Diagnose and recover the simulated incident. Submit `resource-postmortem.md`:
what filled disk and memory (with the exact diagnostic commands), how you
recovered safely, before/after `df -h` and `free -h`, and the guardrail you
added. Commit referencing `OPS-3600`.

---

## 🤖 AI Engineering Exercise

Give an AI your `df -h` + `du` + `free -h` output and ask for a recovery
plan. Verify it does NOT recommend deleting something unsafe (active logs a
process holds open, package caches you need, /var/lib data). Document one
dangerous suggestion you caught — this is exactly where blind trust causes outages.

---

## 🪞 Reflection

- How can a disk be "full" with `df -h` showing free space? (inodes / open files)
- Why look at "available" memory rather than "free"?
- What guardrail would have prevented this entirely?

---

## ✅ Definition of Done

- [ ] Disk and memory consumers identified with evidence.
- [ ] Space and memory recovered without data loss.
- [ ] `df -h` and `free -h` show a healthy host post-recovery.
- [ ] A preventive guardrail is in place.
