# AI Engineering Workflow Guide

Every lesson includes an **AI Engineering Exercise**. The point is not to
have AI do your work — it's to build the professional habit of using AI as a
fast, fallible pair and **verifying everything** before it touches a system.

## The loop: Draft → Verify → Log

1. **Draft.** Ask the AI for a command, script, config, or explanation. Give
   it real context (paste the actual error, the real `ls -l`, the actual log
   sample).
2. **Verify.** *Never* run AI output on a real system unread. Verify with the
   right tool for the artifact:
   | Artifact | Verify with |
   |----------|-------------|
   | Bash script | `shellcheck`, then a dry run in scratch |
   | `find`/`rm` command | run the `find` with **no action** first |
   | sshd config | `sudo sshd -t` |
   | sudoers entry | `sudo visudo -c` |
   | cron schedule | a cron-expression checker; reason through the 5 fields |
   | a factual claim | `man`, official docs, or reproduce it yourself |
3. **Log.** In your notebook record: what you asked, what the AI got right,
   what it got wrong, and how you caught it.

## The golden rule
**Never paste a command you don't understand into a real server.** If you
can't explain what each part does, you're not ready to run it.

## What AI is reliably good / bad at (in this domain)
- **Good:** explaining concepts, drafting boilerplate scripts, narrating a
  small log sample, suggesting which command family to use.
- **Bad / risky:** counting from large files (it eyeballs samples), cron
  field order (swaps day-of-month and day-of-week), `usermod -G` vs `-aG`,
  recommending `curl | bash`, suggesting `chmod 777`, deleting files it can't
  see are still open, assuming your network topology.

## Required notebook note (every AI exercise)
> **AI exercise — <lesson>.** Asked: … | Got right: … | Got wrong / I
> corrected: … | Verified with: …
