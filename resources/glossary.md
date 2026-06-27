# Glossary

**Absolute path** — a path from root (`/etc/hosts`); means the same anywhere.

**Alias** — a shell shortcut for a command; cannot take positional arguments.

**bash** — the Bourne-Again Shell; the default interactive shell on most Linux.

**Daemon** — a long-running background service (e.g. `sshd`, `cron`).

**Environment variable** — a variable `export`ed so child processes inherit it.

**Exit code** — a process's 0 (success) / non-zero (failure) result; machines rely on it.

**FHS** — Filesystem Hierarchy Standard; the conventional meaning of `/etc`, `/var`, etc.

**Glob** — shell wildcard (`*`, `?`, `[...]`) expanded by the shell before the command runs.

**Idempotent** — produces the same end state whether run once or many times.

**Inode** — filesystem object storing a file's metadata; a disk can run out of inodes while showing free space.

**Kernel** — the core program managing hardware, processes, and memory.

**Least privilege** — granting only the minimum access required.

**Loopback** — `127.0.0.1`, the host talking to itself; not reachable externally.

**OOM killer** — kernel mechanism that terminates a process when memory is exhausted.

**PATH** — colon-separated dirs the shell searches to find commands.

**Pipe (`|`)** — connects one command's stdout to the next command's stdin.

**PID / PPID** — process ID / parent process ID.

**Relative path** — interpreted from the current directory (`log/syslog`).

**Repository (apt)** — a signed source of packages; signing provides supply-chain trust.

**setgid** — directory bit making new files inherit the directory's group.

**Shebang** — `#!/usr/bin/env bash`, the first line telling the OS what interprets a script.

**Signal** — a message to a process (SIGTERM polite, SIGKILL forceful).

**stdin/stdout/stderr** — standard input (0), output (1), error (2) streams.

**sudo** — run one command as another user (usually root), logged in auth.log.

**systemd** — the init system and service/timer manager on modern Linux.

**Zombie** — a finished process whose exit status the parent hasn't collected.
