# Lab 11 — SSH (Lesson 11)

> Single-box practice uses `ssh localhost`. Keep a second terminal open
> before changing `sshd_config` so you cannot lock yourself out.

## Goal
Set up key auth and harden sshd safely.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Identify the private key and public key filenames before copying anything.
- Keep a fallback session open before changing server settings.
- Challenge: explain the safe rollout order from memory before editing config.

## Tasks
1. **Generate a key:** `ssh-keygen -t ed25519 -C "swexp" -f ~/.ssh/swexp_ed25519`
2. **Authorize it:**
   ```bash
   mkdir -p ~/.ssh && chmod 700 ~/.ssh
   cat ~/.ssh/swexp_ed25519.pub >> ~/.ssh/authorized_keys
   chmod 600 ~/.ssh/authorized_keys
   ssh -i ~/.ssh/swexp_ed25519 localhost 'echo key-login-ok'
   ```
3. **Client config:** add a `Host` block to `~/.ssh/config`.
4. **Harden (careful):** in `/etc/ssh/sshd_config` set `PermitRootLogin no`,
   `PasswordAuthentication no`. Then:
   ```bash
   sudo sshd -t                 # validate FIRST
   sudo systemctl reload ssh    # reload, do not stop
   # confirm key login in a NEW session before closing this one
   ```

## Deliverable
`ssh-hardening.md` documenting the safe rollout. Solution:
[`../solutions/lab-11-solution.md`](../solutions/lab-11-solution.md).
