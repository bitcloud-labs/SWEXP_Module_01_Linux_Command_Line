# Lesson 3 — Permission Denied

> **Competency:** Permissions
> **Estimated time:** 2–3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    SEC-2031
TITLE:     Deploy script fails with "Permission denied" in production
PRIORITY:  P1 (deploys blocked)
DESCRIPTION:
The deploy pipeline cannot write to /opt/app/releases and the runtime user
cannot read /etc/app/secrets.env. A previous engineer "fixed" a similar
issue with chmod 777, which security has flagged. Diagnose the real
permission model, fix it correctly, and explain why 777 is dangerous.

ACCEPTANCE CRITERIA:
- Deploy user can write to the releases directory.
- Runtime user can read (but not write) the secrets file.
- No world-writable files remain.
- A short writeup of the permission model you applied.
```

---

## 🎯 Learning Objectives

1. Read and interpret the 10-character permission string from `ls -l`.
2. Set permissions with both symbolic (`u+x`) and octal (`750`) notation.
3. Manage ownership with `chown` and `chgrp`.
4. Explain why `777` is almost always wrong, and what to use instead.
5. Understand the role of `sudo` and the principle of least privilege.

---


## 🧭 Beginner Map

### Big idea
Permissions are Linux's safety rules. They answer: who owns this, who can read it, who can change it, and who can run or enter it?

### Key vocabulary
- **Owner:** The user account that controls a file.
- **Group:** A named set of users who can share access.
- **Other:** Everyone who is not the owner and not in the group.
- **Read/write/execute:** The three basic permission actions.
- **Least privilege:** Giving only the access required, not extra access.

### Mental model
Think of a school lab cabinet. The teacher may open and restock it, lab partners may open it during class, and everyone else should not touch it. `777` is like leaving the cabinet unlocked for the entire school.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Reading `ls -l`

```
-rwxr-x---  1  deploy  engineers  4096  Jun 1 12:00  deploy.sh
│└┬┘└┬┘└┬┘     └──┬─┘  └───┬───┘
│ │  │  │         owner    group
│ │  │  └── other: ---  (no access)
│ │  └───── group: r-x  (read + execute)
│ └──────── owner: rwx  (read + write + execute)
└────────── type: - file, d dir, l symlink
```

Each of the three triads is **read (4) / write (2) / execute (1)**.
Permissions apply differently to files vs. directories:

| Bit | On a file        | On a directory                          |
|-----|------------------|-----------------------------------------|
| r   | read contents    | list entries (`ls`)                     |
| w   | modify contents  | create/delete entries inside            |
| x   | execute as program | enter/traverse (`cd`) into it         |

This is the classic gotcha: you can have `r` on a directory but be unable to
`cd` into it without `x`.

### Octal notation

Add the bits per triad. `rwx` = 7, `r-x` = 5, `r--` = 4, `---` = 0.

```bash
chmod 750 deploy.sh   # owner rwx, group r-x, other none
chmod u+x,g-w file    # symbolic: add owner-execute, remove group-write
chmod -R 640 config/  # recursive (watch out: this strips dir +x!)
```

### Ownership

```bash
chown deploy:engineers deploy.sh   # set owner AND group
chown -R appuser /opt/app/releases # whole tree
chgrp engineers report.txt         # group only
```

### Why `777` is dangerous

`777` means **anyone on the system can read, modify, and execute** the file
— including other services, other users, and an attacker who lands a
low-privilege shell. The correct fix is almost always to set the right
**owner/group** and grant the *minimum* bits needed. Secrets like
`secrets.env` should be `640` owned by `root:appgroup` — readable by the
service, writable by no one but root, invisible to everyone else.

### sudo and least privilege

`sudo` runs a single command as another user (usually root). Prefer it over
logging in as root. Grant engineers only the specific `sudo` rights they
need, not blanket root. Every `sudo` use is logged in `/var/log/auth.log`.

---


## 🔎 Guided Command Reading

Read permissions in three chunks: owner, group, other. In `-rw-r-----`, owner is `rw-`, group is `r--`, and other is `---`. Translate each chunk into a sentence before converting to numbers.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Using `chmod 777` because it is quick. It hides the real access problem and creates a security problem.
- Forgetting that directory `x` means the ability to enter/traverse the directory.
- Using recursive permissions on directories and files without noticing they need different execute bits.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- Why can `chmod -R 644 some_directory` break access?
- Who can read a file with mode `640` owned by `root:appgroup`?
- What is the smallest permission set that meets the ticket requirement?

## 🧪 Hands-on Labs

> See [`labs/lab-03-permissions.md`](labs/lab-03-permissions.md).

**Lab 3.1 — Decode permission strings** for ten sample `ls -l` lines.

**Lab 3.2 — Reproduce the bug**: create a dir owned by root, try to write
to it as your user, observe the denial.

**Lab 3.3 — Fix it correctly** with `chown` + `chmod 750` instead of `777`.

**Lab 3.4 — Lock down a secret** to `640 root:appgroup` and verify the
runtime user can read but not write.

---

## 📝 Assignment

Diagnose and fix the SEC-2031 scenario (lab provides the broken setup).
Submit `permissions-writeup.md` showing the *before* (`ls -l`) state, the
exact `chown`/`chmod` commands you ran, the *after* state, and a paragraph
explaining why `777` was wrong. Commit referencing `SEC-2031`.

---

## 🤖 AI Engineering Exercise

Paste an `ls -l` listing to an AI and ask it to translate each permission
string into plain English and flag anything insecure. **Verify** by
computing the octal yourself for at least three lines. Note any line the AI
mislabeled (world-writable files are the ones that matter).

---

## 🪞 Reflection

- Why can `chmod -R 644` *break* a directory tree?
- What's the smallest permission that still satisfies the requirement?
- Where does least privilege apply outside of file permissions?

---

## ✅ Definition of Done

- [ ] Deploy user can write to releases; runtime user can read secrets.
- [ ] No world-writable (`o+w`) files remain (`find / -perm -002` is clean for app dirs).
- [ ] Writeup explains the model and why 777 was rejected.
- [ ] All changes made via `chown`/`chmod`, not `777`.
