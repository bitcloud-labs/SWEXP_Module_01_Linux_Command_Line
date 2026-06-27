# Module Syllabus — Linux & Command Line

## Module Description

A 16-lesson engineering rotation in which learners operate as Junior Software Engineers responsible for the Linux systems their team depends on. Learners close realistic tickets, investigate incidents, automate operations, and deliver a production-ready development server as the capstone.

## Prerequisites

- A computer capable of running Linux (native, WSL2, a VM, a container, or a cloud instance — see `resources/environment-setup.md`)
- Basic comfort with typing commands and reading on-screen output
- High-school-level reading and problem-solving persistence
- A willingness to predict, test, observe, and explain in your own words
- No prior Linux, programming, networking, or server administration experience is assumed; Lesson 0 establishes the baseline

## Duration & Pacing

The module is 16 lessons. It is designed to flex to several delivery cadences:

| Cadence | Pace | Total |
|---------|------|-------|
| Intensive bootcamp | 1 lesson/day | ~3–4 weeks |
| Part-time cohort | 2 lessons/week | ~8 weeks |
| Self-paced | 1 lesson/week | ~16 weeks |

Budget roughly **3–5 hours per lesson** (deep dive + labs + assignment), and **10–15 hours** for the Lesson 15 capstone.

## Module Arc

The lessons are sequenced deliberately. Each phase builds the foundation for the next.

| Phase | Lessons | Theme |
|-------|---------|-------|
| **Foundations** | 0–4 | Orient on the system: filesystem, files, permissions, users |
| **Investigation** | 5–6 | Read the system: text processing and pipelines for log analysis |
| **Engineering** | 7–9 | Shape the system: shell environment, automation, process control |
| **Infrastructure** | 10–14 | Run the system: networking, SSH, packages, scheduling, observability |
| **Delivery** | 15 | Integrate everything into a production-ready server (capstone) |

## Lesson Structure

Every lesson is built from the same repeatable components so you always know where to look:

- **🎫 Engineering Ticket** — the problem you have been assigned, with acceptance criteria
- **🎯 Learning Objectives** — the competency the ticket develops
- **🧭 Beginner Map** — the big idea, vocabulary, analogy, and study strategy
- **📚 Technical Deep Dive** — the mental model and the commands that serve it
- **🔎 Guided Command Reading** — command anatomy, annotated interpretation habits, beginner mistakes, and understanding checks
- **🧪 Hands-on Labs** — reproducible practice in a safe sandbox (`labs/`)
- **📝 Assignment** — the deliverables that close the ticket
- **🤖 AI Engineering Exercise** — practicing the draft → verify → log workflow
- **🪞 Reflection** — consolidating what you learned
- **✅ Definition of Done** — the bar your work must clear

## Deliverables

Across the module you will produce:

- An **engineering notebook** documenting every investigation and decision
- A **Git repository** of your scripts, dotfiles, and configuration
- Closed tickets with reproducible evidence for each lesson
- A **capstone**: a documented, secured, automated development server

## Final Assessment

The **Production Linux Infrastructure Capstone** (Lesson 15, ticket `CAP-9000`). See `assignments/capstone-brief.md` for the full specification. The capstone integrates every competency from the module and is graded against `ASSESSMENT_RUBRIC.md`.

## Support Materials

- `resources/beginner-learning-pattern.md` — predict → run → explain workflow for new learners
- `resources/command-cheatsheet.md` — every command in the module, by lesson
- `resources/glossary.md` — key terms defined
- `resources/troubleshooting-playbook.md` — layered diagnosis recipes
- `resources/ai-workflow-guide.md` — how to use AI responsibly
- `resources/git-workflow.md` — committing your work professionally
