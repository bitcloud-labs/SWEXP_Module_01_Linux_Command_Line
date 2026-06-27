# Lesson 10 — Secure Remote Infrastructure

> **Competency:** Networking
> **Estimated time:** 3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    NET-4001
TITLE:     New server can't reach the database; audit its network exposure
PRIORITY:  P1
DESCRIPTION:
A freshly provisioned app server can't connect to the database, but can
reach the internet. Separately, security wants to know exactly which ports
this box is listening on and to whom. Diagnose the connectivity problem and
produce a network exposure report — what's open, what's connecting out, and
what should be closed.

ACCEPTANCE CRITERIA:
- Root cause of the DB connectivity failure (DNS? port? firewall? service down?).
- A report of all listening ports and their processes.
- Verification of which outbound connections succeed/fail.
- Recommendation for closing unnecessary exposure.
```

---

## 🎯 Learning Objectives

1. Inspect interfaces and addresses with `ip addr` / `ip route`.
2. Test connectivity with `ping`, `curl`, and `nc`.
3. Resolve names with `dig`/`nslookup` and understand `/etc/hosts`.
4. List listening sockets and owning processes with `ss`.
5. Reason about TCP ports, the loopback interface, and firewalls.

---


## 🧭 Beginner Map

### Big idea
Networking problems are easier when you test one layer at a time: address, route, name, reachability, port, service, firewall.

### Key vocabulary
- **Interface:** A network connection on the machine.
- **IP address:** A numeric address for a host or interface.
- **Route:** A rule for where traffic should go.
- **DNS:** The system that turns names into IP addresses.
- **Port:** A numbered door for a network service.
- **Loopback:** The host talking to itself, usually `127.0.0.1`.
- **Firewall:** Rules that allow or block traffic.

### Mental model
Think of sending a package. You need your own address, a road out, the recipient's address, an open door, and permission from security. Networking diagnosis checks each part in order.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### The layers of "it can't connect"

When connectivity fails, isolate the layer methodically:

1. **Interface up?** `ip addr` — does the NIC have an IP?
2. **Route exists?** `ip route` — is there a path to the target?
3. **Name resolves?** `dig db.internal` — does DNS return an address?
4. **Host reachable?** `ping <ip>` — does the host answer (if ICMP allowed)?
5. **Port open?** `nc -zv db.internal 5432` — is the *service* listening/reachable?
6. **Service up on the other end?** `ss -tlnp` on the DB host.

Most "DB unreachable" tickets are DNS (wrong/missing record), a firewall
blocking the port, or the database simply not running. Walk the layers; don't guess.

### Addresses and routes

```bash
ip addr            # interfaces and their IPs (look for inet ...)
ip route           # routing table; the 'default via' is your gateway
```
`127.0.0.1` (loopback) is the host talking to itself — a service bound only
to loopback is unreachable from other machines, a frequent cause of
"works locally, fails remotely."

### Names

```bash
dig +short db.internal     # what IP does this name resolve to?
cat /etc/hosts             # static overrides checked before DNS
```

### Ports and connections

```bash
nc -zv host 5432           # is the port open? (-z scan, -v verbose)
curl -v https://api.internal/health   # full HTTP handshake detail
ss -tlnp                   # TCP, listening, numeric, with process
ss -tnp                    # established connections
```
A **port** identifies a service on a host (5432 = PostgreSQL, 22 = SSH,
80/443 = HTTP/S). `ss -tlnp` is the modern replacement for `netstat` and is
your "what is this box exposing?" command.

### Firewalls

`ufw status` or `iptables -L -n` shows allow/deny rules. A port can be
listening yet blocked by a firewall — both must permit the traffic.

---


## 🔎 Guided Command Reading

Do not jump from `can't connect` to `the network is down`. Ask one small question at a time: do I have an IP, do I have a route, does the name resolve, is the port reachable?

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Assuming ping failure means a host is down; ICMP may be blocked.
- Exposing a service on `0.0.0.0` when it only needed local access.
- Reading listening ports without checking which process owns them.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What is the difference between `127.0.0.1:8080` and `0.0.0.0:8080`?
- Which command tests DNS?
- Which command shows listening TCP ports and process names?

## 🧪 Hands-on Labs

> See [`labs/lab-10-networking.md`](labs/lab-10-networking.md).

**Lab 10.1 — Map your interfaces and routes**; identify your gateway.

**Lab 10.2 — Walk the layers** against a known host (e.g. resolve + `nc` to 443).

**Lab 10.3 — Listening-port audit** with `ss -tlnp`; identify each process.

**Lab 10.4 — Loopback trap**: start a service bound to `127.0.0.1`, prove it's
unreachable externally, then rebind to `0.0.0.0`.

---

## 📝 Assignment

Produce `network-report.md`: your interfaces/routes, a layer-by-layer
connectivity diagnosis to one external host, a table of every listening port
with its owning process, and recommendations for what to close. Commit
referencing `NET-4001`.

---

## 🤖 AI Engineering Exercise

Give an AI your `ss -tlnp` output and ask which ports are risky to expose.
Verify each claim against what the process actually is (`ss` shows the
program). Note any port the AI flagged incorrectly — context (internal vs
internet-facing) changes the answer, and the AI can't see your topology.

---

## 🪞 Reflection

- Which layer is the most common culprit in your experience?
- Why is a service bound to `127.0.0.1` invisible to other hosts?
- "Listening" vs "reachable through the firewall" — why both matter?

---

## ✅ Definition of Done

- [ ] DB connectivity root cause identified by walking the layers.
- [ ] Listening-port table with owning processes.
- [ ] Loopback-vs-external behavior demonstrated.
- [ ] Concrete exposure-reduction recommendations made.
