# Lab 06 — Log Processing Pipeline (Lesson 6)

## Goal
Turn raw access logs into a deterministic report; tee 5xx lines aside.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict what stream goes to which file before running the redirection command.
- Build your report one pipe at a time and save the intermediate observations.
- Challenge: compare file-input and stdin-input output with `diff`.

## Setup
Reuse `access.log` from Lab 05, or regenerate it.

## Tasks
1. **Stream routing:**
   ```bash
   ls /nope /etc > out.txt 2> err.txt; cat out.txt; echo "---"; cat err.txt
   ```
2. **Build the pipeline incrementally** (add one stage, inspect, repeat):
   ```bash
   awk '{print $9}' access.log | sort | uniq -c | sort -rn          # status
   awk '{print $7}' access.log | sort | uniq -c | sort -rn | head   # endpoints
   awk '{print $1}' access.log | sort | uniq -c | sort -rn | head   # IPs
   ```
3. **Tee the 5xx lines while counting:**
   ```bash
   grep -E ' 5[0-9][0-9] ' access.log | tee errors.log | wc -l
   ```
4. **Make it stdin-capable** so both work:
   ```bash
   ./logreport.sh access.log
   cat access.log | ./logreport.sh
   ```

## Deliverable
`logreport.sh` + `report-sample.md`. Solution:
[`../solutions/lab-06-solution.md`](../solutions/lab-06-solution.md).
