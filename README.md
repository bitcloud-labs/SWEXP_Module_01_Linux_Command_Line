# SWEXP Module 1 — Linux & Command Line

> **Software Engineering Experience Program**
> You are not taking a course. You have joined an engineering team as a Junior Software Engineer, and this module is your first rotation: owning the Linux systems your team runs on.

---

## What This Module Is

Most Linux courses teach commands in isolation: here is `ls`, here is `chmod`, memorize the flags. This module does the opposite. It is written for learners who may be encountering Linux for the first time — roughly the level of a motivated senior high school student — so every professional scenario is paired with plain-language explanations, vocabulary, examples, and prediction-based practice. Every lesson opens with a **realistic engineering ticket** — a production incident, an onboarding request, a security hardening task — and you learn the commands because you need them to close the ticket.

By the end you will have built, secured, automated, and documented a **production-ready development server** that you carry forward into every later SWEXP module. The work is cumulative. The server is real. The habits are the ones professional engineers actually use.

## How You Will Work

Every lesson follows the same engineering loop. The ticket gives the professional story, but the teaching path starts from first principles so new learners can understand the ideas before they use the commands:

| Stage | What you do |
|-------|-------------|
| 🎫 **Engineering Ticket** | Read the assigned ticket and its acceptance criteria |
| 🎯 **Learning Objectives** | Understand what competency the ticket builds |
| 🧭 **Beginner Map** | Learn the big idea, vocabulary, and analogy in plain language |
| 📚 **Technical Deep Dive** | Learn the underlying mental model, not just syntax |
| 🔎 **Guided Command Reading** | Break commands into program, options, target, risk, and proof |
| 🧪 **Hands-on Labs** | Practice in a safe sandbox using predict → run → explain |
| 📝 **Assignment** | Close the ticket with real deliverables |
| 🤖 **AI Engineering Exercise** | Use AI the way professionals do: draft → verify → log |
| 🪞 **Reflection** | Write down what you learned and what surprised you |
| ✅ **Definition of Done** | Self-check against the same bar a senior engineer would |

## Learning Outcomes

By completing this module you will be able to:

- Navigate and reason about any Linux filesystem from first principles
- Manage files, users, groups, and permissions safely on multi-user systems
- Process text and build pipelines to investigate logs and data at scale
- Diagnose production incidents: CPU, memory, disk, networking, and failed services
- Secure remote infrastructure with hardened SSH and a trustworthy software supply chain
- Automate repetitive operations with robust, idempotent Bash scripts and scheduled jobs
- Document your work to a professional standard so others can reproduce it
- Use AI tools responsibly, verifying every suggestion before trusting it

## Lesson Index

| # | Lesson | Primary Competency | Ticket |
|---|--------|--------------------|--------|
| 0 | Welcome to the Team | Environment & Workflow | INFRA-1001 |
| 1 | Explore an Unknown Linux System | Filesystem | INFRA-1042 |
| 2 | Recover the Lost Project | File Management | INFRA-1077 |
| 3 | Permission Denied | Permissions | SEC-2031 |
| 4 | Onboard a New Engineering Team | Users & Groups | INFRA-1120 |
| 5 | Investigate a Production Outage Using Log Files | Text Processing | OPS-3301 |
| 6 | Build a Production Log Processing Pipeline | Pipelines | OPS-3344 |
| 7 | Build Your Engineering Workspace | Shell Environment | INFRA-1180 |
| 8 | Automate Developer Onboarding | Bash Automation | INFRA-1205 |
| 9 | Production Service Failure | Process Management | OPS-3401 |
| 10 | Secure Remote Infrastructure | Networking | NET-4001 |
| 11 | Secure SSH Like a Professional | SSH | SEC-2099 |
| 12 | Secure the Software Supply Chain | Package Management | SEC-2150 |
| 13 | Build an Automated Operations Platform | Scheduling | OPS-3500 |
| 14 | Diagnose a Production Server Running Out of Resources | Storage & Observability | OPS-3600 |
| 15 | Linux Infrastructure Capstone | Infrastructure Delivery | CAP-9000 |

## Repository Layout

```
SWEXP_Module_01_Linux_Command_Line/
├── README.md                  ← you are here
├── MODULE_SYLLABUS.md         ← schedule, pacing, prerequisites
├── LEARNER_GUIDE.md           ← how to succeed as a learner
├── INSTRUCTOR_GUIDE.md        ← how to facilitate the module
├── COMPETENCY_MATRIX.md       ← lesson → competency mapping
├── ASSESSMENT_RUBRIC.md       ← how work is graded
├── Lesson_00.md … Lesson_15.md ← the 16 lessons
├── labs/                      ← hands-on lab guides + sandbox generators
├── solutions/                 ← worked solutions and answer keys
├── assignments/               ← submission templates + capstone brief
├── resources/                 ← beginner pattern, cheatsheets, glossary, AI workflow guide
└── instructor-notes/          ← per-lesson facilitation notes
```

## Getting Started

> **Tip:** open `dashboard.html` in a browser for an interactive, filterable view of the whole module — every ticket, its competency and phase, and direct links to the lesson, lab, solution, and notes.

1. Read `MODULE_SYLLABUS.md` for pacing and prerequisites.
2. Read `LEARNER_GUIDE.md` to understand how you are expected to work.
3. Set up your environment with `resources/environment-setup.md`.
4. Open `Lesson_00.md` and claim your first ticket.

> **The golden rule of this module:** never run a command — or paste one from an AI — that you cannot explain. Understanding is the deliverable; the closed ticket is just the evidence.
