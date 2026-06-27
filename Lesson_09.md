# Lesson 9 — Production Service Failure

> **Competency:** Process & Service Management
> **Estimated time:** 3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    OPS-3401
TITLE:     payments.service keeps dying under load — stabilize it
PRIORITY:  P1
DESCRIPTION:
The payments service is flapping: it starts, runs for a minute, then exits.
A runaway process is also pinning a CPU core. Identify the offending
processes, understand why the service won't stay up, and bring it back to a
healthy, auto-restarting state under systemd. Capture evidence so we can
write the postmortem.

ACCEPTANCE CRITERIA:
- Identify the runaway process and its resource usage.
- Determine why the service exits (logs + exit status).
- Restore the service to running + enabled (survives reboot).
- Evidence captured for the postmortem.
```

---

## 🎯 Learning Objectives

1. Inspect processes with `ps`, `top`/`htop`, and `/proc`.
2. Understand PIDs, parent/child, foreground/background, and signals.
3. Send signals with `kill`, `kill -9`, and `pkill`.
4. Manage services with `systemctl` and read logs with `journalctl`.
5. Diagnose why a service fails to stay running.

---


## 🧭 Beginner Map

### Big idea
Processes are programs while they are running. Service management is how Linux starts, stops, restarts, and records long-running programs.

### Key vocabulary
- **Process:** A running program.
- **PID:** The unique number for a process.
- **Signal:** A message sent to a process.
- **Service:** A managed background program.
- **systemd:** The service manager on many Linux systems.
- **Journal:** systemd's log store.
- **Zombie:** A finished process whose parent has not collected its status.

### Mental model
A process is like a student currently doing a task. A PID is their seat number. A signal is a note passed to them: please stop, reload, or stop immediately.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Seeing processes

```bash
ps aux                       # every process, with CPU/MEM
ps aux --sort=-%cpu | head   # top CPU consumers
top        # live, interactive (press 'q' to quit, 'M' sort by memory)
pgrep -fl payments           # find PIDs by name
```
Each process has a **PID** and a **PPID** (parent). When a parent dies,
children may be re-parented to PID 1. A **zombie** (`Z` state) is a finished
process whose parent hasn't collected its exit status — harmless unless they pile up.

### Signals

A signal is a message to a process. The important ones:

| Signal      | Number | Meaning                                  |
|-------------|-------:|------------------------------------------|
| `SIGTERM`   | 15     | Polite "please shut down" (default `kill`)|
| `SIGKILL`   | 9      | Forceful, uncatchable — last resort      |
| `SIGHUP`    | 1      | "reload config" for many daemons         |
| `SIGINT`    | 2      | Ctrl-C                                    |

```bash
kill 4242            # SIGTERM (let it clean up)
kill -9 4242         # SIGKILL (only if TERM fails)
pkill -f runaway.py  # by command pattern
```
Always try `SIGTERM` first. `kill -9` skips cleanup and can corrupt state.

### systemd: the service manager

```bash
systemctl status payments.service     # is it running? recent logs
systemctl start|stop|restart payments.service
systemctl enable payments.service     # start on boot
systemctl enable --now payments.service  # enable AND start
journalctl -u payments.service -e      # this service's logs, jump to end
journalctl -u payments.service --since "10 min ago"
```
`status` shows the last exit code and a few log lines — your first stop when
a service won't stay up. A non-zero `Result:` plus `Restart=` thrashing
usually means the process is crashing on startup; `journalctl` tells you why.

### Foreground, background, jobs

```bash
long_task &        # run in background
jobs               # list background jobs
fg %1              # bring job 1 to foreground
nohup cmd &        # survive terminal logout
```

---


## 🔎 Guided Command Reading

Start with polite shutdown. `kill PID` sends SIGTERM. Wait and check. Only use `kill -9` if the process ignores the polite request and you understand the cleanup risk.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Using `kill -9` first.
- Confusing a service that is not enabled with a service that is not currently running.
- Reading only `ps` and missing the reason for failure in `journalctl`.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What does PID identify?
- What can `systemctl status` show that `ps` cannot?
- Why should evidence for a postmortem include logs and not just commands?

## 🧪 Hands-on Labs

> See [`labs/lab-09-process-management.md`](labs/lab-09-process-management.md);
> it ships a fake crashing service and a CPU-burner you can safely kill.

**Lab 9.1 — Spot the runaway** with `ps --sort=-%cpu` and stop it gracefully.

**Lab 9.2 — Signals**: start a backgrounded sleep, kill with TERM, then KILL.

**Lab 9.3 — Read why a service died** via `systemctl status` + `journalctl`.

**Lab 9.4 — Restore** the service to running + enabled.

---

## 📝 Assignment

Stabilize the failing service in the lab environment. Submit
`postmortem.md` with: the runaway PID and its usage, the service's exit
status and the log line explaining the crash, the commands used to restore
it, and a prevention idea. Commit referencing `OPS-3401`.

---

## 🤖 AI Engineering Exercise

Paste a `systemctl status` block and the tail of `journalctl` into an AI and
ask for the likely root cause. Verify by reproducing the failure and
confirming the fix actually keeps the service up across a restart. Note
whether the AI distinguished "crashing" from "misconfigured to not restart."

---

## 🪞 Reflection

- When is `kill -9` justified, and what does it risk?
- What does `systemctl status` tell you that `ps` cannot?
- Why "enable" *and* "start" — what's the difference?

---

## ✅ Definition of Done

- [ ] Runaway process identified and stopped gracefully.
- [ ] Root cause of the service exit documented from logs.
- [ ] Service is `active (running)` and `enabled`.
- [ ] Postmortem captures evidence and a prevention idea.
