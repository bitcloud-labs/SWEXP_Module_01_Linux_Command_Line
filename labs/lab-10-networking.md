# Lab 10 — Networking (Lesson 10)

## Goal
Walk the connectivity layers and audit listening ports.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict whether `github.com` will fail at DNS, route, port, or HTTP before testing.
- Record each layer's evidence separately.
- Challenge: explain why a service bound to loopback is safer for local-only tools.

## Tasks
1. **Interfaces + routes:** `ip addr; ip route` — identify your default gateway.
2. **Walk the layers to a known host:**
   ```bash
   dig +short github.com
   nc -zv github.com 443
   curl -sS -o /dev/null -w '%{http_code}\n' https://github.com
   ```
3. **Listening-port audit:**
   ```bash
   ss -tlnp 2>/dev/null    # add sudo to see process names
   ```
4. **Loopback trap:**
   ```bash
   python3 -m http.server 8080 --bind 127.0.0.1 &
   ss -tlnp | grep 8080     # bound to 127.0.0.1 only
   kill %1
   ```

## Deliverable
`network-report.md` with interfaces/routes, a layer-by-layer diagnosis, and a
listening-port table. Solution:
[`../solutions/lab-10-solution.md`](../solutions/lab-10-solution.md).
