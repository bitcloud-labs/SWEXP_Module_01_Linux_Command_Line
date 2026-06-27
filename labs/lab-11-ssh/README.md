# Lab 11 — SSH

**Goal:** write a clean `~/.ssh/config` `Host` block so `ssh prod` just works —
no long `-i`/`-l` flags to remember.

Generating keys, authorizing them, and hardening `sshd_config` happen on the LMS box
(and risk lockout, so they need a fallback session). Here we grade the gradable core:
**emitting a correct client-config block.**

## What you do
Complete [`solution.sh`](solution.sh). Given `<host> <hostname> <user> <identity>`,
print a valid SSH config block to stdout containing:

```
Host <host>
  HostName <hostname>
  User <user>
  IdentityFile <identity>
```

```bash
npx bats labs/lab-11-ssh/tests
./solution.sh prod 203.0.113.10 deploy '~/.ssh/swexp_ed25519'
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, write the **safe rollout order** for hardening sshd
  (`sshd -t` → reload → confirm in a new session) from memory.

## Submit
Commit and push.
