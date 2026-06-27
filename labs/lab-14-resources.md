# Lab 14 — Out of Resources (Lesson 14)

> All operations are confined to a scratch directory and are bounded so they
> cannot harm your host. Read each step before running it.

## Goal
Diagnose simulated disk and memory pressure and recover safely.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict whether the disk test consumes blocks, inodes, or memory.
- Record before/after output so recovery is visible.
- Challenge: explain the deleted-but-open trap using a classroom analogy.

## Setup

```bash
mkdir -p ~/swexp-lab/l14 && cd ~/swexp-lab/l14
```

## Tasks

1. **Fill a scratch dir, then find it:**
   ```bash
   # create a 200 MB file (adjust if space is tight)
   dd if=/dev/zero of=big.bin bs=1M count=200 status=none
   du -sh ~/swexp-lab/l14/*
   du -xh "$HOME" 2>/dev/null | sort -rh | head
   rm big.bin && echo "reclaimed"
   ```
2. **Inode demonstration (scratch only):**
   ```bash
   mkdir tiny && (cd tiny && for i in $(seq 1 5000); do : > "f$i"; done)
   df -i .          # note IFree dropping
   rm -rf tiny
   ```
3. **Deleted-but-open trap:**
   ```bash
   dd if=/dev/zero of=held.log bs=1M count=100 status=none
   sleep 300 < held.log &          # a process holds the file open
   rm held.log                      # space NOT yet freed
   lsof +L1 2>/dev/null | grep held # find the holder
   kill %1                          # release it -> space freed
   ```
4. **Memory + OOM evidence (bounded):**
   ```bash
   free -h
   journalctl -k 2>/dev/null | grep -i 'out of memory\|oom' | tail
   # Inspect top memory users WITHOUT exhausting RAM:
   ps aux --sort=-%mem | head -5
   ```

## Deliverable
`resource-postmortem.md`: what consumed disk (and the deleted-but-open
finding), before/after `df -h`/`free -h`, and a guardrail you'd add. Compare
to [`../solutions/lab-14-solution.md`](../solutions/lab-14-solution.md).
