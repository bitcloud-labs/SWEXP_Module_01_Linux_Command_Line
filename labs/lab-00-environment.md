# Lab 00 — Environment (Lesson 0)

## Goal
Stand up a Linux box you control and open your engineering notebook.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict: before running `whoami`, guess the username Linux will report.
- Run each identity command separately, then write one sentence explaining its output.
- Challenge: ask a classmate to rebuild your environment from your notes only.

## Tasks
1. **Provision** (pick one):
   - WSL2: `wsl --install -d Ubuntu`
   - Docker: `docker run -it --name swexp ubuntu:24.04 bash`
   - VM/cloud: smallest Ubuntu 24.04 instance.
2. **Identify the box:**
   ```bash
   whoami; pwd; id; uname -a; cat /etc/os-release
   ```
3. **Open the notebook:**
   ```bash
   mkdir -p ~/swexp-engineering-notebook && cd ~/swexp-engineering-notebook
   git init
   git config user.name "Your Name"; git config user.email "you@example.com"
   printf '# Engineering Notebook\n\n## %s — Environment\n\nProvisioning path:\nOS:\nNotes:\n' "$(date +%F)" > NOTEBOOK.md
   git add NOTEBOOK.md && git commit -m "INFRA-1001: open engineering notebook"
   ```

## Deliverable
A committed `NOTEBOOK.md` whose Environment entry lets a teammate reproduce
your box. Solution: [`../solutions/lab-00-solution.md`](../solutions/lab-00-solution.md).
