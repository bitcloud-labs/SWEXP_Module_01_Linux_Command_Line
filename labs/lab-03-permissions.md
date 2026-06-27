# Lab 03 — Permissions (Lesson 3)

## Goal
Reproduce a "permission denied" bug and fix it correctly (no 777).


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Translate every permission string into a sentence before changing it.
- After `chmod`, test what changed using `ls -l` instead of trusting memory.
- Challenge: explain why a secret file should usually not be readable by `other`.

## Setup
```bash
mkdir -p ~/swexp-lab/l03 && cd ~/swexp-lab/l03
echo "API_KEY=shhh" > secrets.env
chmod 666 secrets.env      # too open, on purpose
mkdir releases
```

## Tasks
1. **Decode** ten permission strings (use real `ls -l /usr/bin | head`).
2. **Inspect:** `ls -l secrets.env` — what is wrong with `666`?
3. **Fix the secret** to least privilege:
   ```bash
   chmod 640 secrets.env
   ls -l secrets.env          # owner rw, group r, other none
   ```
4. **Find anything world-writable** in your lab dir:
   ```bash
   find ~/swexp-lab/l03 -perm -002 -type f
   ```

## Deliverable
`permissions-writeup.md` with before/after `ls -l` and why 640 (not 777).
Solution: [`../solutions/lab-03-solution.md`](../solutions/lab-03-solution.md).
