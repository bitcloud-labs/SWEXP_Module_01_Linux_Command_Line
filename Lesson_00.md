# Lesson 0 — Welcome to the Team

> **SWEXP Role:** Junior Software Engineer, Platform & Infrastructure
> **Competency:** Engineering Onboarding & Environment Setup
> **Estimated time:** 2–3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    INFRA-1001
TITLE:     New engineer onboarding — establish your working environment
PRIORITY:  P2 (blocking your first sprint)
ASSIGNEE:  You
REPORTER:  Platform Team Lead

DESCRIPTION:
Welcome to the Platform team. Before you can be assigned production work,
you must stand up a working Linux environment, prove you can reach it,
and open your engineering notebook + Git repository. We don't hand out
production access until a new engineer can demonstrate a reproducible,
documented setup.

ACCEPTANCE CRITERIA:
- A Linux environment you control (VM, WSL2, cloud instance, or container).
- You can show `uname -a`, `whoami`, and `pwd` output.
- A Git repository named `swexp-engineering-notebook` exists with at
  least one commit.
- Your notebook contains an "Environment" entry describing how the box
  was created so a teammate could reproduce it.
```

---

## 🎯 Learning Objectives

By the end of this lesson you will be able to:

1. Explain what a shell, a terminal, and a kernel are, and how they relate.
2. Choose and provision a Linux environment appropriate to your hardware.
3. Navigate a filesystem and identify your current context (`whoami`, `pwd`, `id`).
4. Initialize a Git repository and make a first commit.
5. Keep an **engineering notebook** the way a professional engineer does.

---


## 🧭 Beginner Map

### Big idea
A Linux computer is a set of layers. You type into a terminal window, the shell reads your command, and Linux does the work. Before you can solve bigger problems, you need to know where you are, who you are, and how to record what you did.

### Key vocabulary
- **Terminal:** The window or app where you type commands.
- **Shell:** The program, usually Bash, that reads your command and starts programs.
- **Kernel:** The core of Linux that manages hardware, memory, files, and running programs.
- **Command:** A small instruction you ask the shell to run.
- **Engineering notebook:** A dated record of what you tried, what happened, and what you learned.

### Mental model
Think of Linux like a school building. The terminal is the front desk window, the shell is the person who takes your request, and the kernel is the building operations team that can actually unlock rooms, turn on power, and move equipment. You do not talk to the operations team directly; your commands go through the shell.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### The mental model: kernel → shell → terminal

Linux is a **kernel** — the program that talks to hardware, schedules
processes, and owns memory. You never talk to the kernel directly. Instead
you type into a **shell** (commonly `bash` or `zsh`), a program that reads
your commands, asks the kernel to do the work, and prints results. The
**terminal** (or terminal *emulator*) is just the window that displays the
shell. People say "the command line," "the terminal," and "the shell"
interchangeably, but they are three distinct layers.

```
You ⟶ Terminal (the window) ⟶ Shell (bash) ⟶ Kernel ⟶ Hardware
```

### Where am I, and who am I?

Three commands answer the questions every session begins with:

| Command   | Question it answers              | Example output            |
|-----------|----------------------------------|---------------------------|
| `whoami`  | Which user am I acting as?       | `engineer`                |
| `pwd`     | Which directory am I in?         | `/home/engineer`          |
| `id`      | What groups/privileges do I have?| `uid=1000(engineer) ...`  |
| `uname -a`| What kernel/OS am I on?          | `Linux box 6.x ... x86_64`|

A surprising amount of production confusion comes from engineers not
knowing *which user on which host* they are. Build the habit now.

### The engineering notebook

Professional engineers keep a running log of what they did, why, and what
happened. It is not a diary — it is a reproducibility tool. When an incident
postmortem asks "what changed?", your notebook is the answer. We keep ours
in Markdown, in Git, so every change is timestamped and reviewable.

---


## 🔎 Guided Command Reading

Run `whoami`, `pwd`, and `id` one at a time before running them together. After each command, say out loud: `who am I?`, `where am I?`, and `what groups am I part of?` If the answer surprises you, stop and write it down.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Copying setup commands without knowing which machine they affect.
- Forgetting to configure Git name/email before the first commit.
- Writing notebook notes like `set up Linux` instead of exact reproducible steps.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- Explain the difference between terminal and shell without using the word `thing`.
- Point to the command output that proves which OS you are using.
- List the exact steps a friend would need to rebuild your environment.

## 🧪 Hands-on Labs

> Full step-by-step versions live in [`labs/lab-00-environment.md`](labs/lab-00-environment.md).

**Lab 0.1 — Provision your box.** Pick one path:
- **WSL2** (Windows): `wsl --install -d Ubuntu`
- **VM**: Install Ubuntu Server 24.04 in VirtualBox/UTM.
- **Cloud**: Smallest available instance on any provider.
- **Container** (fastest): `docker run -it --name swexp ubuntu:24.04 bash`

**Lab 0.2 — Identify yourself.** Run and capture the output of:
```bash
whoami; pwd; id; uname -a; cat /etc/os-release
```

**Lab 0.3 — Open your notebook.**
```bash
mkdir -p ~/swexp-engineering-notebook && cd ~/swexp-engineering-notebook
git init
printf '# Engineering Notebook\n\n## %s — Environment\n' "$(date +%F)" > NOTEBOOK.md
git add NOTEBOOK.md && git commit -m "INFRA-1001: open engineering notebook"
```

---

## 📝 Assignment

Write your first **Environment** notebook entry. It must let a teammate
reproduce your setup *without asking you a single question*. Include: the
provisioning path you chose, the exact commands or steps, the OS version,
and one thing that surprised you. Commit it referencing `INFRA-1001`.

---

## 🤖 AI Engineering Exercise

Ask an AI assistant: *"Explain the difference between a shell, a terminal,
and a kernel, then quiz me with three questions."* Then **verify** its
answer against `man bash` and `uname --help`. In your notebook, record one
thing the AI got right and one thing you had to correct or confirm yourself.
**Never paste a command you don't understand into a real server** — this is
the rule that survives every later lesson.

---

## 🪞 Reflection

- What was confusing about the kernel/shell/terminal distinction?
- If your laptop died right now, how long would it take to rebuild this box?
- What will you put in your notebook that "future you" will thank you for?

---

## ✅ Definition of Done

- [ ] Linux environment provisioned and reachable.
- [ ] `whoami`, `pwd`, `id`, `uname -a` output captured in the notebook.
- [ ] Git repo `swexp-engineering-notebook` created with ≥1 commit.
- [ ] Environment entry is reproducible by a teammate.
- [ ] AI exercise completed with a verification note.
