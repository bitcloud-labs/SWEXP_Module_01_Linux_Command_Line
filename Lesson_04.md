# Lesson 4 — Onboard a New Engineering Team

> **Competency:** Users & Groups
> **Estimated time:** 2–3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    INFRA-1120
TITLE:     Provision accounts and access for the new Payments squad
PRIORITY:  P2
DESCRIPTION:
A four-person Payments squad starts Monday. They need user accounts, a
shared `payments` group, a shared working directory only their group can
touch, and sane defaults so new files they create stay group-accessible.
Two of them need limited sudo (service restarts only). Do this
reproducibly — we onboard teams constantly.

ACCEPTANCE CRITERIA:
- Four user accounts with home directories and a default shell.
- A `payments` group containing all four.
- A shared dir /srv/payments that only the group can read/write.
- New files in the shared dir inherit the group (setgid).
- Two users granted sudo for systemctl restart only.
```

---

## 🎯 Learning Objectives

1. Create and manage users (`useradd`, `passwd`, `usermod`, `userdel`).
2. Create and manage groups and supplementary group membership.
3. Read `/etc/passwd`, `/etc/group`, and `/etc/shadow`.
4. Use the **setgid** bit and shared directories for team collaboration.
5. Grant scoped `sudo` rights via `/etc/sudoers.d/`.

---


## 🧭 Beginner Map

### Big idea
Users and groups let many people safely share one Linux system. Instead of giving everyone full control, you create accounts, put the right people in the right groups, and share directories through group rules.

### Key vocabulary
- **User account:** An identity Linux can assign files and processes to.
- **Primary group:** The default group for a user's new files.
- **Supplementary group:** An extra group a user belongs to.
- **setgid directory:** A directory where new files inherit the directory's group.
- **sudoers:** Configuration controlling who may run commands as another user.

### Mental model
A group is like a club roster. If a folder belongs to the `payments` club, then club members can collaborate there while non-members stay out.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Where users live

`/etc/passwd` has one line per account:
```
alice:x:1001:1001:Alice Ng:/home/alice:/bin/bash
└─┬─┘ │ └─┬┘ └─┬┘ └──┬──┘ └───┬────┘ └───┬───┘
 name pwd uid  gid  GECOS    home       shell
```
The `x` means the password hash lives in `/etc/shadow` (readable only by
root). `/etc/group` maps group names to GIDs and lists members.

### Creating users and groups

```bash
groupadd payments
useradd -m -s /bin/bash -G payments alice   # -m home, -s shell, -G group
passwd alice                                # set initial password
usermod -aG payments bob                    # ADD to group (-a is critical!)
```

> **Trap:** `usermod -G payments bob` *replaces* all of bob's supplementary
> groups. Always use `-aG` to *append*.

### Shared directories and setgid

A normal new file gets the creator's primary group. For a shared team dir
you want every new file to belong to `payments` automatically. The
**setgid** bit on a directory does exactly that:

```bash
mkdir -p /srv/payments
chgrp payments /srv/payments
chmod 2770 /srv/payments     # leading 2 = setgid; 770 = group rwx, other none
```

Now any file created inside inherits the `payments` group. The `2` is the
setgid bit; `1` would be the sticky bit (used on `/tmp`).

### Scoped sudo

Never hand out full root. Drop a file in `/etc/sudoers.d/`:
```
# /etc/sudoers.d/payments-restart
alice ALL=(root) NOPASSWD: /usr/bin/systemctl restart payments.service
```
Validate it with `visudo -c` — a syntax error in sudoers can lock everyone out.

---


## 🔎 Guided Command Reading

When reading `/etc/passwd`, split the line on colons. Each field has a job: username, password marker, UID, GID, description, home directory, and shell. Do not memorize first; learn to decode.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Running `usermod -G group user` on an existing user and accidentally replacing their other groups.
- Making shared directories world-writable instead of using group ownership and setgid.
- Editing sudoers without validation.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What does `-a` add to `usermod -aG`?
- How can you prove a new file inherited the `payments` group?
- Why should sudo access be limited to specific commands?

## 🧪 Hands-on Labs

> See [`labs/lab-04-users-groups.md`](labs/lab-04-users-groups.md).

**Lab 4.1 — Create the squad**: four users + `payments` group.

**Lab 4.2 — Build the shared dir** with setgid; prove inheritance by
creating a file as one user and checking its group.

**Lab 4.3 — Cross-user test**: as user A, create a file; as user B (same
group), edit it. Confirm a non-member is denied.

**Lab 4.4 — Scoped sudo**: grant restart rights and verify other commands
are still refused.

---

## 📝 Assignment

Onboard the Payments squad on your box. Deliver an **idempotent**
`onboard-payments.sh` script (it should be safe to run twice), plus
`onboarding-report.md` showing `/etc/group`, the shared dir permissions,
and a successful cross-user write test. Commit referencing `INFRA-1120`.

---

## 🤖 AI Engineering Exercise

Ask an AI to write the onboarding script for you. Then **audit it line by
line**: does it use `-aG` or the destructive `-G`? Does it set passwords
insecurely? Does it make the script idempotent? Record at least one issue
you found and fixed. (Most AI-generated user scripts get group append or
idempotency wrong.)

---

## 🪞 Reflection

- Why is `usermod -aG` vs `-G` such a common production incident?
- What does setgid buy you that plain group ownership doesn't?
- How would you offboard the squad just as cleanly?

---

## ✅ Definition of Done

- [ ] Four accounts + `payments` group exist.
- [ ] `/srv/payments` is setgid and group-restricted.
- [ ] New files inherit the group (demonstrated).
- [ ] Two users have scoped sudo; `visudo -c` passes.
- [ ] Onboarding script is idempotent.
