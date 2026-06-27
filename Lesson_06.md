# Lesson 6 — Build a Production Log Processing Pipeline

> **Competency:** Pipelines, Redirection & Regex
> **Estimated time:** 3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    OPS-3344
TITLE:     Nightly log report — turn raw access logs into a metrics summary
PRIORITY:  P2
DESCRIPTION:
After OPS-3301 we want a repeatable report we can run on demand: total
requests, status-code breakdown, top 10 endpoints, top 10 client IPs, and a
list of any 5xx lines saved to a separate file for review. It must read
from a file OR from stdin (so it can sit in a pipeline), and write clean
output we could email.

ACCEPTANCE CRITERIA:
- A single pipeline/script producing the report.
- Reads from a file argument or stdin.
- 5xx lines saved to errors.log via redirection.
- Output is deterministic and human-readable.
```

---

## 🎯 Learning Objectives

1. Compose commands with pipes (`|`) into data pipelines.
2. Redirect stdin/stdout/stderr (`<`, `>`, `>>`, `2>`, `2>&1`, `tee`).
3. Understand the three standard streams and exit codes.
4. Write extended regular expressions for matching and extraction.
5. Combine `grep`/`awk`/`sort`/`uniq`/`tee` into a reusable report.

---


## 🧭 Beginner Map

### Big idea
A pipeline is an assembly line for text. Each command does one small job, then passes its output to the next command.

### Key vocabulary
- **stdin:** Input stream number 0.
- **stdout:** Normal output stream number 1.
- **stderr:** Error output stream number 2.
- **Pipe:** Connects one command's stdout to the next command's stdin.
- **Redirection:** Sends input/output to or from files.
- **Deterministic:** Produces the same output every time for the same input.

### Mental model
Imagine a school lunch line: tray → food → drink → checkout. A pipeline is similar: raw log → filter → extract → count → report.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Three streams, three numbers

Every process has **stdin (0)**, **stdout (1)**, and **stderr (2)**. By
default stdout and stderr both go to your terminal, but they are separate
channels so you can route them independently.

```bash
cmd > out.txt        # stdout to file (truncate)
cmd >> out.txt       # stdout appended
cmd 2> err.txt       # stderr to file
cmd > out.txt 2>&1   # both to same file (order matters!)
cmd < input.txt      # feed file as stdin
cmd 2>/dev/null      # discard stderr
```

`2>&1` means "send stream 2 to wherever stream 1 currently points." Put it
*after* the redirect of stdout, or it won't follow.

### Pipes: stdout of one → stdin of next

```bash
cat access.log | grep " 500 " | awk '{print $7}' | sort | uniq -c | sort -rn
```

Each `|` connects programs into a small assembly line. Prefer
`grep ... file` over `cat file | grep ...` when there's a single input —
but in teaching pipelines, `cat` makes the data flow obvious.

### tee: split the stream

`tee` writes to a file **and** passes data onward, so you can save and keep
processing:
```bash
grep -E " 5[0-9][0-9] " access.log | tee errors.log | wc -l
```

### Reading from file OR stdin

A robust report reads `"$1"` if given, else stdin. The idiom:
```bash
cat "${1:-/dev/stdin}" | ...    # use arg 1, or stdin if absent
```

### Regex levels

- **BRE** (basic, default grep): `\+`, `\?` are literal-ish; escape groups.
- **ERE** (`grep -E`, `awk`): `+ ? | ( )` work without backslashes.
Use `grep -E` for anything non-trivial. Common atoms: `^` start, `$` end,
`[0-9]` digit class, `.` any char, `\.` literal dot.

---


## 🔎 Guided Command Reading

Build pipelines one pipe at a time. Run the first command and inspect the output. Then add the next `| command`. If the output becomes wrong, the bug is probably in the stage you just added.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Forgetting that stderr is separate from stdout.
- Putting `2>&1` before redirecting stdout and expecting both streams to go to the file.
- Optimizing a pipeline before proving the output is correct.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What flows through a pipe?
- Why does `tee` help when you need to save and continue processing?
- How can you prove two versions of a report are identical?

## 🧪 Hands-on Labs

> See [`labs/lab-06-pipeline.md`](labs/lab-06-pipeline.md).

**Lab 6.1 — Stream routing**: redirect stdout and stderr to different files.

**Lab 6.2 — Build the report pipeline** incrementally, adding one stage at a time.

**Lab 6.3 — `tee` the 5xx lines** to `errors.log` while counting them.

**Lab 6.4 — Make it stdin-capable** so `cat access.log | report.sh` works.

---

## 📝 Assignment

Write `logreport.sh`: reads a file arg or stdin, prints total requests,
status breakdown, top 10 endpoints, top 10 IPs, and tees 5xx lines to
`errors.log`. Include sample output in `report-sample.md`. Commit
referencing `OPS-3344`.

---

## 🤖 AI Engineering Exercise

Ask an AI to "explain this pipeline" — paste your longest pipe chain. Verify
each stage by running the pipeline truncated at each `|`. Then ask the AI to
optimize it; test whether its "optimization" produces *identical* output
(it often changes ordering). Record the diff.

---

## 🪞 Reflection

- Why does the position of `2>&1` matter?
- When is `cat file |` an anti-pattern, and when is it fine?
- How would you turn this report into a nightly cron job? (Foreshadows L13.)

---

## ✅ Definition of Done

- [ ] `logreport.sh` reads file arg AND stdin.
- [ ] Report includes counts, status breakdown, top endpoints/IPs.
- [ ] 5xx lines tee'd to `errors.log`.
- [ ] Output is deterministic across runs.
