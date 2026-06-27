# Learner Guide

## You Are Learning to Think Like an Engineer

This module is designed for a motivated beginner, including a senior high school student who has not used Linux before. You are not expected to already know server vocabulary. You are expected to slow down, make predictions, test them, and explain what happened in clear language.

## You Are an Engineer, Not a Student

The single most important mindset shift in this module: **you are a Junior Software Engineer on a team, completing real work.** Lessons are tickets. Labs are your sandbox. The notebook is your professional record. When you finish the module, you should be able to point to artifacts — scripts, configs, documentation, a working server — and say "I built that, and I can explain every line."

This changes how you should approach problems:

- **Investigate before you ask.** When something breaks, your first move is to look — read the error, check the logs, inspect the state. Senior engineers are not people who memorized answers; they are people who know how to find them.
- **Understand before you run.** Never execute a command you cannot explain, especially one suggested by an AI. If you do not understand it, look it up first. This is the golden rule of the module.
- **Document as you go.** If it is not written down, it did not happen. Your engineering notebook is graded as seriously as your commands.

## How Each Lesson Works

Work through a lesson in order:

1. **Read the ticket.** Understand what "done" means before touching the keyboard.
2. **Study the Beginner Map and deep dive.** Learn the big idea, vocabulary, and mental model before trying to memorize commands.
3. **Do the labs using predict → run → explain.** Each lab gives you safe practice. Before each command, predict what will happen; after it runs, explain the output in your own words.
4. **Complete the assignment.** This is what actually closes the ticket. Produce the deliverables.
5. **Do the AI exercise.** Practice drafting with AI, then verifying and logging — the workflow you will use for the rest of your career.
6. **Write your reflection.** A few honest sentences about what clicked and what was hard.
7. **Check the Definition of Done.** Hold yourself to the bar before submitting.

## What Every Assignment Must Include

Treat these as non-negotiable parts of "done," regardless of the specific ticket:

- **Engineering notebook updates** — what you did, what you observed, what you decided, and why
- **Documentation** — clear enough that a teammate could reproduce your work without you
- **Git commits** — small, meaningful commits with messages that explain the *why*
- **Reflection** — honest self-assessment
- **AI verification** — evidence that you checked, not just trusted, any AI output
- **Definition of Done** — the checklist at the end of each lesson, satisfied

Use `assignments/submission-template.md` as your per-lesson deliverable format.

## Using AI Responsibly

AI tools are part of modern engineering, and this module teaches you to use them well rather than pretending they do not exist. The workflow is always the same:

1. **Draft** — ask the AI for a first pass at a command, script, or explanation.
2. **Verify** — check it against documentation, `--help`, a man page, or a safe test. Confirm you understand *why* it works.
3. **Log** — record in your notebook what you asked, what you got, how you verified it, and what you changed.

The full method, including a verification-tool table, is in `resources/ai-workflow-guide.md`. The one rule that overrides everything: **never paste a command you don't understand.**

## When You Get Stuck

Work the problem in this order before reaching for help:

1. **Read the error message.** It is usually telling you exactly what is wrong.
2. **Check the relevant log** (`journalctl`, files under `/var/log`, etc.).
3. **Consult** `resources/troubleshooting-playbook.md` for a layered diagnosis recipe.
4. **Look up the command** in `resources/command-cheatsheet.md` or with `man`.
5. **Reproduce it small.** Strip the problem down to the smallest case that still fails.
6. **Then ask** — but ask with what you have already tried and observed.

## The Server You Build Is Forever

The development server you build, secure, and document in this module is **reused throughout the rest of the SWEXP program.** Every shortcut you take now is debt you carry into later modules; every habit you build well now pays off repeatedly. Build it like you will have to live with it — because you will.

## How You Are Graded

Your work is assessed against `ASSESSMENT_RUBRIC.md`. Note that technical correctness is necessary but not sufficient: documentation, engineering practice, automation quality, and responsible AI use all carry real weight. A correct command with no explanation and no notebook entry is not a finished ticket.
