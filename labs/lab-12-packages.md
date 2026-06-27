# Lab 12 — Packages & Supply Chain (Lesson 12)

> Requires `sudo`/`apt` (Debian/Ubuntu). On other distros, map to the local
> package manager.

## Goal
Patch, inventory, and lock down package installation.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict whether `apt update` will change installed software.
- Use inventory commands before and after install/remove.
- Challenge: write a safer alternative for one install guide that suggests `curl | bash`.

## Tasks
1. **Refresh + see what's pending:**
   ```bash
   sudo apt update
   apt list --upgradable 2>/dev/null
   ```
2. **Inventory + ownership:**
   ```bash
   apt list --installed 2>/dev/null | wc -l
   dpkg -S /bin/ls          # which package owns this file?
   ```
3. **Install + inspect:**
   ```bash
   sudo apt install -y tree
   dpkg -L tree | head
   ```
4. **Remove + purge + autoremove:**
   ```bash
   sudo apt remove --purge -y tree
   sudo apt autoremove -y
   ```

## Deliverable
`package-audit.md` with before/after counts and a "trusted install" policy
that replaces `curl | bash`. Solution:
[`../solutions/lab-12-solution.md`](../solutions/lab-12-solution.md).
