# Lesson 7 — Build Your Engineering Workspace

> **Competency:** Shell Environment & Configuration
> **Estimated time:** 2 hours

---

## 🎫 Engineering Ticket

```
TICKET:    INFRA-1180
TITLE:     Standardize the team's shell environment
PRIORITY:  P3
DESCRIPTION:
Every engineer's shell is configured differently, which makes pairing and
debugging painful. Define a sane, documented default environment: a useful
prompt, common aliases, sensible PATH handling, and an editor default. It
must be version-controlled (dotfiles) so a fresh box can be configured in
one command.

ACCEPTANCE CRITERIA:
- A versioned dotfiles repo with .bashrc / .bash_aliases.
- A clear, informative prompt (PS1) showing user, host, and cwd.
- At least 8 useful, safe aliases and 2 functions.
- A one-command bootstrap that symlinks dotfiles into place.
```

---

## 🎯 Learning Objectives

1. Distinguish environment variables from shell variables; use `export`.
2. Explain `PATH` and how the shell resolves commands.
3. Customize the prompt (`PS1`) and create aliases and functions.
4. Understand startup files: `.bashrc` vs `.bash_profile` vs `.profile`.
5. Manage dotfiles in Git for reproducible environments.

---


## 🧭 Beginner Map

### Big idea
Your shell environment is your workbench. Variables, PATH, aliases, functions, and dotfiles decide what tools are easy to reach and how repeatable your setup is.

### Key vocabulary
- **Shell variable:** A value known only to the current shell.
- **Environment variable:** A value exported to child programs.
- **PATH:** Directories searched when you type a command name.
- **Alias:** A shortcut for a command.
- **Function:** A reusable shell command that can accept arguments.
- **Dotfile:** A hidden configuration file, usually starting with `.`.

### Mental model
A clean workbench has labeled drawers and tools in predictable places. Dotfiles are the instructions for rebuilding that workbench on a new computer.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Variables and the environment

```bash
NAME="checkout"        # shell variable (this shell only)
export NAME            # now exported to child processes (environment)
echo "$NAME"; printenv NAME
```
Child processes inherit the *environment*, not plain shell variables. This
is why `export` matters for things like `PATH` and `EDITOR`.

### PATH: how a command is found

`PATH` is a colon-separated list of directories. When you type `ls`, the
shell searches each directory in `PATH` in order and runs the first match.
`which ls` / `type ls` shows what would run.
```bash
echo "$PATH"
export PATH="$HOME/bin:$PATH"   # prepend your own bin (takes priority)
```
Appending vs prepending changes precedence — prepend to override, append to
keep system commands first.

### Startup files (the confusing part)

- **Login shell** (SSH in, console): reads `.bash_profile` → which usually
  sources `.bashrc`.
- **Interactive non-login shell** (new terminal tab): reads `.bashrc`.
- Best practice: put everything in `.bashrc`, and have `.bash_profile`
  source it, so behavior is consistent.

### A useful prompt

```bash
# user@host:cwd$  with color
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
```
`\u` user, `\h` host, `\w` working dir, `\$` becomes `#` for root.

### Aliases and functions

```bash
alias ll='ls -lah'
alias gs='git status'
alias ..='cd ..'
mkcd() { mkdir -p "$1" && cd "$1"; }   # a function takes arguments
```
Aliases can't take positional args the way functions can — reach for a
function when you need `$1`.

---


## 🔎 Guided Command Reading

Use `type command_name` before assuming what will run. It tells you whether a word is an alias, function, shell builtin, or executable file found through PATH.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Changing PATH in a way that hides system commands.
- Putting interactive-only commands in startup files used by non-interactive scripts.
- Creating clever aliases that are unsafe or confusing to teammates.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- Why does `export EDITOR=vim` affect child programs but `EDITOR=vim` alone may not?
- When should you use a function instead of an alias?
- How does a bootstrap script lower the cost of a new laptop?

## 🧪 Hands-on Labs

> See [`labs/lab-07-dotfiles.md`](labs/lab-07-dotfiles.md).

**Lab 7.1 — Inspect** your current `PATH`, `HOME`, and `SHELL`.

**Lab 7.2 — Build a prompt** and reload with `source ~/.bashrc`.

**Lab 7.3 — Add aliases + an `mkcd` function**; prove they survive a new shell.

**Lab 7.4 — Bootstrap script** that symlinks dotfiles from the repo.

---

## 📝 Assignment

Create a `dotfiles` Git repo with `.bashrc`, `.bash_aliases`, and an
`install.sh` that symlinks them into `$HOME` (backing up any existing
files). Document each alias/function in the repo README. Commit referencing
`INFRA-1180`.

---

## 🤖 AI Engineering Exercise

Ask an AI to design a `PS1` prompt that shows the current git branch. Verify
it doesn't slow your shell to a crawl (the naive version runs `git` on every
prompt). Measure with `time` and note the tradeoff in your notebook.

---

## 🪞 Reflection

- Why does `export` matter, and what breaks without it?
- What's the difference between an alias and a function, practically?
- How does versioning dotfiles change the cost of a new laptop?

---

## ✅ Definition of Done

- [ ] Dotfiles repo with `.bashrc`/`.bash_aliases` committed.
- [ ] Informative colored prompt working.
- [ ] ≥8 aliases + 2 functions, all documented.
- [ ] `install.sh` reproducibly configures a fresh shell.
