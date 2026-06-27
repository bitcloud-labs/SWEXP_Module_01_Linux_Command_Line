# Lab 09 — Production Service Failure (Lesson 9)

## Goal
Find a runaway process, stop it gracefully, and understand why a service
won't stay up — then restore it.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict which process will appear near the top of CPU usage.
- Try SIGTERM before SIGKILL and record what happened.
- Challenge: explain the difference between `start` and `enable` in one sentence.

## Setup — safe CPU burner + a "crashing service" simulation

```bash
mkdir -p ~/swexp-lab/l09 && cd ~/swexp-lab/l09

# A bounded CPU burner you can find and kill (auto-stops after 120s)
cat > burner.sh <<'SH'
#!/usr/bin/env bash
end=$(( $(date +%s) + 120 ))
while [ "$(date +%s)" -lt "$end" ]; do :; done
SH
chmod +x burner.sh
./burner.sh &
echo "burner PID: $!"
```

## Tasks

1. **Find the runaway** by CPU:
   ```bash
   ps aux --sort=-%cpu | head -5
   pgrep -fl burner
   ```
2. **Stop it gracefully, then forcefully if needed:**
   ```bash
   kill <PID>        # SIGTERM
   sleep 2; kill -0 <PID> 2>/dev/null && kill -9 <PID>   # escalate if still alive
   ```
3. **Signals practice:**
   ```bash
   sleep 600 & echo "sleep PID $!"
   kill -SIGTERM %1        # job spec also works
   jobs
   ```
4. **(If you have systemd + a sample unit)** read why a unit died:
   ```bash
   systemctl status <unit> --no-pager
   journalctl -u <unit> -e --no-pager | tail -30
   ```
   Look for the non-zero `Result:`/exit code and the last log line before exit.

## Deliverable
`postmortem.md`: the runaway PID + its %CPU, the exact signals you sent, and
(if applicable) the log line explaining a service exit. Compare to
[`../solutions/lab-09-solution.md`](../solutions/lab-09-solution.md).
