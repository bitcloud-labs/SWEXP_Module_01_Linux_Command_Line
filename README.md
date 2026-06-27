# SWEXP Module 01 — Linux & Command Line · Interactive Workspace

> **Software Engineering Experience Program** — work-along starter workspace.
> This is the **hands-on companion** to Module 01. The lessons, deep dives, and the
> full capstone live in the Forge LMS; this repository is where you *do the work*:
> open an exercise, complete a `solution.sh`, run the tests, and push to be graded.

It is designed to run inside the LMS **code-server** (or any Linux box / Codespace).
Every exercise is a small, sandbox-safe Bash task with a `bats` test spec — no `sudo`,
no mutating your real system. You practise the gradable *core* of each lesson here;
the system-state work (real `useradd`, hardening `sshd`, systemd timers) is done in
your LMS box and written up in your engineering notebook.

---

## Quick start

```bash
npm install        # installs bats (the only dependency)
npm test           # run every exercise's tests (the spec)
npm run grade      # score yourself exactly like the autograder does
npm run check      # shell-syntax gate (bash -n) over every solution.sh
```

Work one exercise at a time:

```bash
npx bats labs/lab-00-environment/tests   # run just this lab's tests
```

Open the folder, read its `README.md`, complete the `# TODO`s in `solution.sh`,
and re-run the tests until they are green. **The `tests/*.bats` file is the spec** —
it defines exactly what "done" means.

---

## How it works

Each exercise folder contains:

| File | Purpose |
|------|---------|
| `README.md` | what the task is and how it maps to the lesson |
| `solution.sh` | **you edit this** — a starter with `# TODO` guidance (it fails until you complete it) |
| `fixtures/` | sample data (an `os-release`, an `access.log`, a `df` dump, …) where needed |
| `tests/*.bats` | the grading spec — runs your `solution.sh` and asserts its effects/output |

The autograder (`scripts/grade.mjs`) auto-discovers every folder under `labs/` and
`assignments/` that has a `tests/` directory, runs its `bats` tests, applies a
`bash -n` syntax gate, and prints a per-exercise score. You get the **same** report
locally (`npm run grade`) that CI posts on your pull request.

---

## Exercises

| Folder | Topic | What your `solution.sh` does |
|--------|-------|------------------------------|
| `labs/lab-00-environment` | Environment | Parse `/etc/os-release` and print `PRETTY_NAME` |
| `labs/lab-01-filesystem-survey` | Filesystem | Count files/dirs and name the largest file in a tree |
| `labs/lab-02-file-recovery` | File management | `find` `*.log` files and copy them into `recovered/` |
| `labs/lab-03-permissions` | Permissions | Tighten a secret to `640`, list world-writable files |
| `labs/lab-04-users-groups` | Users & groups | Print a group's members from an `/etc/group` file |
| `labs/lab-05-log-investigation` | Text processing | Busiest client IP + total 4xx/5xx count from an access log |
| `labs/lab-06-pipeline` | Pipelines | Status-code tally + tee 5xx lines to `errors.log` |
| `labs/lab-07-dotfiles` | Shell environment | Idempotently symlink dotfiles into a home dir |
| `labs/lab-08-onboarding-script` | Bash automation | Prereq check + idempotent onboarding |
| `labs/lab-09-process-management` | Processes | Find the highest-`%CPU` PID from `ps aux` output |
| `labs/lab-10-networking` | Networking | List unique listening TCP ports from `ss -ltn` output |
| `labs/lab-11-ssh` | SSH | Emit a valid `~/.ssh/config` `Host` block |
| `labs/lab-12-packages` | Packages | Report which wanted packages are missing |
| `labs/lab-13-scheduling` | Scheduling | Build the weekday-09:00 crontab line |
| `labs/lab-14-resources` | Storage | Flag filesystems over a use% threshold from `df -P` |
| `assignments/capstone` | Capstone core | Health check: world-writable + disk + missing packages |

> The numbering matches the lessons. Labs 00–14 are the per-lesson cores; the capstone
> integrates several of them into one report. The **full** CAP-9000 capstone (idempotent
> `provision.sh`, systemd service, hardened SSH, ops layer, docs, `v1.0-capstone` tag) is
> completed in your LMS box — see `assignments/capstone-brief.md` and the submission
> template.

---

## Grading & submission

1. Complete an exercise's `solution.sh`; run `npm test` (or the per-lab `npx bats …`).
2. When `npm run grade` shows the exercise green, commit and push:
   ```bash
   git add -A
   git commit -m "feat: complete lab-00 environment"
   git push
   ```
3. The **Autograde** GitHub Action (`.github/workflows/autograde.yml`) re-runs the
   grader on every push and on pull requests, and posts your score to the job summary
   (and as a PR comment). The check is green only when **every** exercise passes and
   every `solution.sh` parses cleanly.

For lesson write-ups and reflections, copy `assignments/submission-template.md`
(and `assignments/capstone-submission-template.md` for the capstone) into your notebook.

---

## Repository layout

```
.
├── README.md                  ← you are here
├── package.json               ← npm scripts: test / grade / check
├── scripts/grade.mjs          ← the autograder (don't edit)
├── .github/workflows/         ← Autograde CI
├── .devcontainer/             ← one-click Codespaces / code-server setup
├── labs/                      ← lab-00 … lab-14 (README + solution.sh + tests)
├── assignments/               ← capstone core + submission templates
└── resources/                 ← cheatsheet, glossary, AI-workflow guide, setup notes
```

> **The golden rule of this module:** never run a command — or paste one from an AI —
> that you cannot explain. Understanding is the deliverable; the green check is just
> the evidence.
