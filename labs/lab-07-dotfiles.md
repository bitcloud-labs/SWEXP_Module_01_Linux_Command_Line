# Lab 07 — Dotfiles (Lesson 7)

## Goal
Build a versioned, reproducible shell environment.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict whether `NAME=value` will appear in `printenv NAME` before and after `export`.
- Use `type` to check aliases/functions before relying on them.
- Challenge: open a new shell and prove your changes survived.

## Tasks
1. **Inspect environment:** `echo "$PATH"; echo "$HOME"; echo "$SHELL"; type ll 2>/dev/null`
2. **Prompt:** add to `~/.bashrc`, then `source ~/.bashrc`:
   ```bash
   PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
   ```
3. **Aliases + function:**
   ```bash
   alias ll='ls -lah'; alias ..='cd ..'; alias gs='git status'
   mkcd(){ mkdir -p "$1" && cd "$1"; }
   ```
4. **Repo + bootstrap:**
   ```bash
   mkdir -p ~/dotfiles && cd ~/dotfiles && git init
   cp ~/.bashrc ./bashrc
   printf '#!/usr/bin/env bash\nset -euo pipefail\nln -sfn "$PWD/bashrc" "$HOME/.bashrc"\n' > install.sh
   chmod +x install.sh
   git add . && git commit -m "INFRA-1180: dotfiles"
   ```

## Deliverable
A `dotfiles` repo with documented aliases and an `install.sh`. Solution:
[`../solutions/lab-07-solution.md`](../solutions/lab-07-solution.md).
