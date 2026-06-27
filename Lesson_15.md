# Lesson 15 — Linux Infrastructure Capstone

> **Competency:** Infrastructure Delivery (Integrative)
> **Estimated time:** 8–12 hours (multi-session)

---

## 🎫 Engineering Ticket (Capstone Engagement)

```
EPIC:      CAP-9000
TITLE:     Deliver a production-ready Linux development server
PRIORITY:  P1 (graduation gate)
DESCRIPTION:
The Platform team is commissioning a hardened, automated, observable
development server that the rest of the SWEXP program will build on. You own
it end to end. It must be secure, documented, automated, and reproducible —
if your laptop died, a teammate should be able to rebuild it from your repo.
This integrates every competency from Lessons 0–14.

ACCEPTANCE CRITERIA: see the Definition of Done below.
```

> The full brief, rubric mapping, and submission checklist live in
> [`assignments/capstone-brief.md`](assignments/capstone-brief.md).

---

## 🎯 Learning Objectives

This capstone is **integrative** — it assesses your ability to combine,
under realistic constraints, everything you've practiced:

1. Provision and document a server (L0–L1).
2. Organize a clean filesystem and project layout (L2).
3. Apply correct permissions and least privilege (L3).
4. Manage users, groups, and shared access (L4).
5. Process logs and build a reporting pipeline (L5–L6).
6. Standardize the shell environment via versioned dotfiles (L7).
7. Automate setup with robust, idempotent scripts (L8).
8. Run services reliably under systemd (L9).
9. Audit and constrain network exposure (L10).
10. Harden SSH for key-only access (L11).
11. Patch and secure the software supply chain (L12).
12. Schedule backups, rotation, and health checks (L13).
13. Add resource guardrails and observability (L14).

---


## 🧭 Beginner Map

### Big idea
The capstone is where separate skills become a complete system. You are proving that you can build, secure, automate, observe, and explain a Linux server from scratch.

### Key vocabulary
- **Provision:** Create and configure a system so it is ready to use.
- **Runbook:** Instructions for operating and fixing a system.
- **Hardening:** Reducing unnecessary risk and exposure.
- **Evidence map:** A table connecting each requirement to proof.
- **Release tag:** A Git marker for a finished version.
- **Integration:** Making parts work together as one system.

### Mental model
This is like building and presenting a science fair project: the device must work, but your notebook, diagram, safety choices, and repeatable procedure are also part of the grade.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📐 What You Will Build

A single server (your reused SWEXP box) configured as a **production-ready
development server**, delivered as a Git repository containing:

1. **`provision.sh`** — an idempotent bootstrap that, run on a fresh box,
   reproduces your entire configuration (users, dirs, packages, dotfiles,
   services, schedules). Strict mode, logging, `shellcheck`-clean.
2. **A demo service** managed by systemd (`active` + `enabled`), bound
   appropriately (not accidentally on `0.0.0.0` if it shouldn't be).
3. **Hardened SSH** (key-only, no root, no passwords) with a documented safe
   rollout.
4. **An ops layer**: scheduled backup with retention, logrotate, and a
   health check, all observable.
5. **A log-reporting pipeline** (`logreport.sh` from L6, generalized).
6. **Versioned dotfiles** with a one-command install.
7. **Documentation**: `README.md` (architecture + how to rebuild),
   `RUNBOOK.md` (operate it: backup, restore, restart, where logs are),
   `SECURITY.md` (the hardening you applied and why), and your ongoing
   engineering notebook.

---


## 🔎 Guided Command Reading

Do not build the capstone as one giant task. Finish one phase, commit it, test it, and write down proof before moving to the next phase.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Treating the capstone as a checklist instead of a system someone else must operate.
- Leaving old shortcuts in place, especially broad permissions or unverified scripts.
- Writing documentation after the fact and forgetting the decisions that matter.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- Could another learner rebuild your server without asking you questions?
- Where is every acceptance criterion proven?
- What would fail safely if one part of your system broke?

## 🧪 Build Phases

Work in phases, committing at each one (your Git history is graded):

- **Phase 1 — Foundation:** provision, filesystem, users/groups, permissions.
- **Phase 2 — Automation:** the idempotent `provision.sh`, dotfiles install.
- **Phase 3 — Services & Network:** demo service under systemd, network audit.
- **Phase 4 — Security:** SSH hardening, package patching, least privilege.
- **Phase 5 — Operations:** backups, rotation, health checks, guardrails.
- **Phase 6 — Documentation & Demo:** README, RUNBOOK, SECURITY, and a
  recorded or written walkthrough showing a from-scratch rebuild.

---

## 📝 Assignment / Deliverable

Submit the Git repository URL plus a `CAPSTONE-SUBMISSION.md` that maps each
acceptance criterion to the file/command that satisfies it, and includes the
output of a clean `provision.sh` run on a fresh box. Tag the release
`v1.0-capstone`. This server is **reused for the rest of SWEXP**, so build it
to live with.

---

## 🤖 AI Engineering Exercise

Throughout the capstone, use AI as a pair — to draft scripts, review configs,
and explain errors — but **every AI-suggested change must be verified** with
the appropriate tool (`shellcheck`, `sshd -t`, `visudo -c`, a test run) and
logged in your notebook. Your submission must include an "AI workflow" section
describing where AI helped, what it got wrong, and how you caught it.

---

## 🪞 Reflection

- If your laptop died tonight, how long to rebuild this server from your repo?
- Which lesson's competency was hardest to integrate, and why?
- What would you do differently knowing the whole program builds on this box?

---

## ✅ Definition of Done

- [ ] `provision.sh` rebuilds the server idempotently and is `shellcheck`-clean.
- [ ] Demo service is `active (running)` and `enabled`, correctly bound.
- [ ] SSH is key-only; root and password auth disabled; `sshd -t` passes.
- [ ] Packages patched; least-privilege sudo; no world-writable app files.
- [ ] Scheduled backup (with retention), logrotate, and health check all observable.
- [ ] Dotfiles versioned with one-command install.
- [ ] README, RUNBOOK, SECURITY, and notebook complete.
- [ ] `CAPSTONE-SUBMISSION.md` maps every criterion to evidence; release tagged.
