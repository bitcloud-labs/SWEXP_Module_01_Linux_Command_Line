# Lab 04 — Users & Groups (Lesson 4)

> Requires `sudo`. Practice on a disposable box/VM/container.

## Goal
Onboard a team with a shared, setgid working directory.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict which group a new file in `/srv/payments` will have.
- After creating each user/group, verify with `id` or `getent`.
- Challenge: create a non-member user and prove access is denied.

## Tasks
1. **Group + users:**
   ```bash
   sudo groupadd payments
   for u in alice bob carol dave; do sudo useradd -m -s /bin/bash -G payments "$u"; done
   getent group payments
   ```
2. **Shared setgid dir:**
   ```bash
   sudo mkdir -p /srv/payments
   sudo chgrp payments /srv/payments
   sudo chmod 2770 /srv/payments
   ls -ld /srv/payments        # note the 's' in group perms
   ```
3. **Prove inheritance:**
   ```bash
   sudo -u alice bash -c 'touch /srv/payments/from-alice && ls -l /srv/payments'
   # group should be 'payments', not 'alice'
   ```
4. **Scoped sudo (optional):** create `/etc/sudoers.d/payments-restart` and
   validate with `sudo visudo -c`.

## Deliverable
`onboarding-report.md` showing the group, dir perms, and inheritance proof.
Solution: [`../solutions/lab-04-solution.md`](../solutions/lab-04-solution.md).
