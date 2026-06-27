# Lesson 11 — Secure SSH Like a Professional

> **Competency:** SSH & Remote Access
> **Estimated time:** 3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    SEC-2099
TITLE:     Harden SSH on the bastion host
PRIORITY:  P1
DESCRIPTION:
Our bastion accepts password logins and allows direct root login — auth.log
shows thousands of brute-force attempts daily. Move the team to key-based
authentication, disable passwords and root login, and document a safe
rollout so nobody locks themselves out. Keep a tested fallback session open
during changes.

ACCEPTANCE CRITERIA:
- Key-based auth working for all team members.
- Password auth and direct root login disabled.
- A safe change procedure that prevents lockout.
- Reduced brute-force noise demonstrated in auth.log.
```

---

## 🎯 Learning Objectives

1. Generate and manage SSH key pairs (`ssh-keygen`, `ssh-copy-id`).
2. Understand public/private key authentication vs passwords.
3. Configure the client with `~/.ssh/config`.
4. Harden `sshd_config` (disable passwords/root, change defaults).
5. Use `scp`/`rsync` and SSH tunneling for secure transfer and access.

---


## 🧭 Beginner Map

### Big idea
SSH is a secure way to control another computer. Hardening SSH means proving trusted users can still get in while making password guessing and root login much harder.

### Key vocabulary
- **SSH:** Secure Shell, a protocol for remote login.
- **Key pair:** A private key kept secret and a public key shared with the server.
- **authorized_keys:** The server file listing public keys allowed to log in.
- **sshd:** The SSH server daemon.
- **Fallback session:** An already-open connection kept in case the new configuration fails.
- **Tunnel:** A secure path through SSH to reach another service.

### Mental model
A public key is like a lock you give the server. Your private key is the only key that can open it. The server can test you without ever seeing your private key.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### How key auth works

You generate a **key pair**: a private key (stays on your laptop, never
shared) and a public key (copied to the server). The server challenges you
to prove you hold the private key without ever sending it. This defeats
password brute-forcing entirely.

```bash
ssh-keygen -t ed25519 -C "you@team"     # modern, strong, short keys
ssh-copy-id user@server                 # installs your pubkey on the server
ssh user@server                         # now logs in with the key
```
The public key lands in the server's `~/.ssh/authorized_keys`. Protect the
private key: `chmod 600 ~/.ssh/id_ed25519`. Use a passphrase + `ssh-agent`.

### Client config

`~/.ssh/config` turns long commands into short aliases:
```
Host bastion
    HostName 203.0.113.10
    User engineer
    IdentityFile ~/.ssh/id_ed25519
    Port 22
```
Now `ssh bastion` just works.

### Hardening sshd (the careful part)

Edit `/etc/ssh/sshd_config`:
```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```
**Golden rule:** before applying, confirm key login works in a *separate*
session, and keep your current session open. Validate config with
`sshd -t`, then `systemctl reload ssh`. If you disable password auth without
a working key, you lock yourself out — which is why we keep a fallback session.

### Moving data

```bash
scp file.txt bastion:/tmp/             # copy a file over SSH
rsync -avz --progress dir/ bastion:/srv/dir/   # efficient, resumable sync
ssh -L 5432:db.internal:5432 bastion   # tunnel: local 5432 → db via bastion
```
`rsync` only transfers differences — far better than `scp` for large or
repeated transfers. The tunnel lets you reach an internal DB through the
bastion without exposing it publicly.

---


## 🔎 Guided Command Reading

Safe rollout order matters: create key, prove key login works, keep current session open, validate config with `sshd -t`, reload, test a new session, then close the old one.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Disabling passwords before proving key login works.
- Sharing or emailing a private key.
- Stopping SSH instead of reloading it during a remote change.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- Which half of the key pair may be copied to a server?
- What command validates sshd config before reload?
- How does a fallback session prevent lockout?

## 🧪 Hands-on Labs

> See [`labs/lab-11-ssh.md`](labs/lab-11-ssh.md). If you have one box, you can
> practice loopback SSH (`ssh localhost`) safely.

**Lab 11.1 — Generate an ed25519 key** and inspect both halves.

**Lab 11.2 — Authorize the key** and log in without a password.

**Lab 11.3 — Write a `~/.ssh/config`** alias and connect with it.

**Lab 11.4 — Harden safely**: validate with `sshd -t`, reload, confirm in a
second session *before* closing the first.

---

## 📝 Assignment

Harden SSH on your box (or a loopback target). Submit `ssh-hardening.md`
documenting your safe rollout procedure, the `sshd_config` diffs, proof that
key auth works and password/root login are refused, and the fallback plan
that prevented lockout. Commit referencing `SEC-2099`.

---

## 🤖 AI Engineering Exercise

Ask an AI for a "secure sshd_config." Critically review it: does it preserve
a way back in? Does it disable something you actually rely on? Cross-check
each directive against `man sshd_config`. Document one suggestion you
*rejected* because it would have caused lockout in your setup.

---

## 🪞 Reflection

- Why is key auth fundamentally safer than even a strong password?
- What is the single most likely way to lock yourself out, and how did you avoid it?
- When would you reach for `rsync` over `scp`?

---

## ✅ Definition of Done

- [ ] Key-based login works; private key permissions are `600`.
- [ ] Password auth and root login disabled and verified.
- [ ] `sshd -t` passes; change made without losing access.
- [ ] Safe rollout procedure documented.
