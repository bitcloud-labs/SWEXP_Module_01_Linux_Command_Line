# Lesson 5 — Investigate a Production Outage Using Log Files

> **Competency:** Text Processing
> **Estimated time:** 3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    OPS-3301
TITLE:     Checkout API returned 500s for ~20 minutes — find the cause
PRIORITY:  P1 (revenue impact)
DESCRIPTION:
Between 14:00 and 14:25 UTC customers saw checkout failures. We have the
access log and the application log. Find when it started, how many requests
were affected, which endpoint, and the most likely root cause — using only
the command line. No log-aggregation UI is available on this box.

ACCEPTANCE CRITERIA:
- The exact first and last timestamp of the 500 spike.
- Count of affected requests and the top offending endpoint.
- The application error message correlated with the spike.
- A timeline reconstructed purely from log text.
```

---

## 🎯 Learning Objectives

1. View and follow logs with `cat`, `less`, `head`, `tail -f`.
2. Search text with `grep` (and `-i`, `-v`, `-c`, `-n`, `-E`, `-r`).
3. Extract and reshape fields with `cut`, `awk`, and `sort | uniq -c`.
4. Edit streams with `sed`.
5. Reconstruct an incident timeline from raw logs.

---


## 🧭 Beginner Map

### Big idea
Logs are the computer's diary. Text tools help you find patterns in that diary: when a problem started, how many users were affected, and what probably caused it.

### Key vocabulary
- **Log:** A text record of events from a system or application.
- **Filter:** Keep only lines that match a condition.
- **Field:** One piece of a structured line, such as status code or URL.
- **Regex:** A pattern language for matching text.
- **Timeline:** Events ordered by time so cause and effect are easier to see.

### Mental model
Investigating logs is like reviewing security camera timestamps. First find the suspicious window, then count what happened, then match it with another camera angle.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### The viewers

`less` is the pager you live in: `/pattern` searches, `n`/`N` jumps between
hits, `G` goes to the end, `q` quits. For live logs, `tail -f file.log`
streams new lines as they're written — the single most-used incident command.

### grep: find the needle

```bash
grep "500" access.log              # lines containing 500
grep -c "500" access.log           # COUNT matching lines
grep -i "error" app.log            # case-insensitive
grep -v "healthcheck" access.log   # INVERT: lines NOT matching
grep -n "Exception" app.log        # show line numbers
grep -E "50[0-9]" access.log       # extended regex: 500–509
grep -r "panic" /var/log/          # recursive across files
```

### awk: columns and counting

A typical access-log line is space-separated. `awk` treats each field as
`$1, $2, ...`:
```bash
# Count requests per HTTP status (field 9 in common log format)
awk '{print $9}' access.log | sort | uniq -c | sort -rn

# Show only requests with status 500
awk '$9 == 500 {print $7}' access.log    # $7 = the URL path
```

`sort | uniq -c | sort -rn` is the **"top N" idiom** — memorize it. `uniq`
only collapses *adjacent* duplicates, so you must `sort` first.

### cut and sed

```bash
cut -d' ' -f1 access.log           # first space-delimited field (IP)
cut -d: -f1 /etc/passwd            # usernames from passwd
sed -n '100,120p' app.log          # print only lines 100–120
sed 's/secret=[^ ]*/secret=REDACTED/' app.log  # redact in stream
```

### Putting it together — a timeline

```bash
grep " 500 " access.log | awk '{print $4, $7}' | head   # when + what
grep -i exception app.log | head -5                      # the why
```

---


## 🔎 Guided Command Reading

For an access log line, number the fields with your finger before using `awk`. In common log format, `$1` is often IP, `$7` is path, and `$9` is status. Verify this with `head -1 access.log` before trusting a command.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Counting a sample and treating it like the whole file.
- Using `uniq -c` before sorting, which splits identical items into separate groups.
- Reporting 500 errors as the cause instead of the symptom.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What does each stage in `awk '{print $9}' access.log | sort | uniq -c | sort -rn` do?
- Which command gives you the first matching error?
- What evidence links the app log to the access log?

## 🧪 Hands-on Labs

> See [`labs/lab-05-log-investigation.md`](labs/lab-05-log-investigation.md);
> it generates realistic `access.log` and `app.log` files with a planted incident.

**Lab 5.1 — Status breakdown** with the top-N idiom.

**Lab 5.2 — Bound the incident**: first and last 500 timestamps.

**Lab 5.3 — Find the endpoint** driving the errors.

**Lab 5.4 — Correlate** the app-log exception to the spike window.

---

## 📝 Assignment

Investigate the planted outage and write `incident-timeline.md`: a minute-by-
minute reconstruction with the commands you used, the affected count, the
offending endpoint, and your root-cause hypothesis. Commit referencing
`OPS-3301`.

---

## 🤖 AI Engineering Exercise

Paste 50 log lines into an AI and ask it to summarize the incident. Then
run the equivalent `grep`/`awk` yourself on the *full* file. AIs are great
at narrating a sample but will miss volume — note where your full-file count
differed from the AI's eyeballed estimate.

---

## 🪞 Reflection

- Why must you `sort` before `uniq -c`?
- Which single command would you reach for first in a live outage?
- What did the app log tell you that the access log couldn't?

---

## ✅ Definition of Done

- [ ] First/last 500 timestamps identified.
- [ ] Affected request count and top endpoint reported.
- [ ] App-log error correlated to the window.
- [ ] Timeline reproducible from the documented commands.
