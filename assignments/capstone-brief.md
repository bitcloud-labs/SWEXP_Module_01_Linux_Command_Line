# Capstone Brief — CAP-9000: Production-Ready Linux Development Server

> The capstone for Module 1. Integrates Lessons 0–14. Budget 8–12 hours
> across multiple sessions. This server is **reused for the rest of SWEXP.**

## The engagement

You own the delivery of a hardened, automated, observable Linux development
server, handed off as a Git repository. The bar: **if your laptop died
tonight, a teammate could rebuild the server from your repo without asking
you anything.**

## Required deliverables

1. **`provision.sh`** — idempotent bootstrap (strict mode, logging,
   `shellcheck`-clean) that reproduces the whole configuration on a fresh box:
   users/groups, directory layout + permissions, baseline packages, dotfiles,
   the demo service, and the scheduled ops jobs. Running it twice changes nothing.
2. **Demo service under systemd** — `active (running)` and `enabled`, bound to
   the correct interface (don't expose on `0.0.0.0` unless intended), with a
   working `Restart=` policy.
3. **Hardened SSH** — key-only auth, `PermitRootLogin no`,
   `PasswordAuthentication no`, validated with `sshd -t`, rolled out without
   lockout (documented procedure).
4. **Operations layer** — scheduled backup with retention, `logrotate` for app
   logs, and a periodic health check; all observable (logs / `list-timers` /
   status file).
5. **Log-reporting pipeline** — a generalized `logreport.sh` (from Lesson 6).
6. **Versioned dotfiles** — with a one-command `install.sh`.
7. **Documentation:**
   - `README.md` — architecture + exact rebuild steps.
   - `RUNBOOK.md` — operate it: how to back up, restore, restart, where logs live.
   - `SECURITY.md` — what you hardened and why.
   - Engineering notebook — ongoing, including an "AI workflow" section.
8. **`CAPSTONE-SUBMISSION.md`** — maps every acceptance criterion to the
   file/command that satisfies it, plus the output of a clean `provision.sh`
   run on a fresh box. Tag the release `v1.0-capstone`.

## Acceptance criteria → rubric mapping

| Criterion | Rubric category | Evidence |
|-----------|-----------------|----------|
| `provision.sh` idempotent + shellcheck-clean | Automation (20%) | two clean runs |
| Demo service running/enabled, bound correctly | Linux Admin (20%) | `systemctl status`, `ss -tlnp` |
| SSH key-only, no root/password | Security (15%) | `sshd -t`, failed password attempt |
| Packages patched, least-privilege sudo | Security (15%) | `apt` log, `sudoers.d`, `visudo -c` |
| Backup+retention, rotation, health check | Automation / Admin | `list-timers`, backup dir |
| README/RUNBOOK/SECURITY/notebook | Documentation (15%) | the files |
| Clean Git history, ticket refs, tag | Engineering Practices (15%) | `git log` |
| Recovery scenario handled | Troubleshooting (10%) | postmortem section |
| AI verification logged throughout | AI Workflow (5%) | notebook section |

## Suggested phase plan
- **P1 Foundation:** provision, fs, users/groups, permissions.
- **P2 Automation:** `provision.sh`, dotfiles install.
- **P3 Services & Network:** demo service, network audit.
- **P4 Security:** SSH hardening, patching, least privilege.
- **P5 Operations:** backups, rotation, health checks, guardrails.
- **P6 Docs & Demo:** README/RUNBOOK/SECURITY + from-scratch rebuild proof.

## Definition of Done
See the checklist at the bottom of [`../Lesson_15.md`](../Lesson_15.md). Every
box must be checked and evidenced in `CAPSTONE-SUBMISSION.md`.
