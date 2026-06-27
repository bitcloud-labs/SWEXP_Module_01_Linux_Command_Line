# Lab 01 — Filesystem Survey (Lesson 1)

## Goal
Map an unfamiliar system read-only and flag findings.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict which top-level directory will contain logs before listing `/`.
- Run `pwd` before every relative-path command until you can predict where it will act.
- Challenge: draw a small tree showing `/`, `/home`, `/etc`, `/var`, and your current directory.

## Tasks
1. **Identity:** `cat /etc/os-release; uname -r; nproc; free -h`
2. **Layout:** `ls -lah /; ls -lah /etc | head; ls -lah /var/log`
3. **Heavy hitters:**
   ```bash
   df -h
   du -sh /var/* 2>/dev/null | sort -rh | head
   ```
4. **Classify files (trust `file`, not the extension):**
   ```bash
   cd ~/swexp-lab && mkdir -p l01 && cd l01
   echo hello > a.txt; cp /bin/ls ./b; file a.txt b
   stat a.txt
   ```

## Deliverable
`survey.md` with OS/kernel, CPU/RAM, `df -h`, three largest `/var` dirs, and
three findings. Solution: [`../solutions/lab-01-solution.md`](../solutions/lab-01-solution.md).
