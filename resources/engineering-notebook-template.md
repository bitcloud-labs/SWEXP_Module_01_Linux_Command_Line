# Engineering Notebook — Templates

Copy these into your `swexp-engineering-notebook` repo. Keep entries in
Markdown, commit them, and reference the ticket ID.

## Daily / ticket entry
```markdown
## YYYY-MM-DD — TICKET-ID — <short title>

**Goal:** what I set out to do.

**What I did:**
- command / change (and *why*)

**What happened:** observed output / result.

**Decisions & tradeoffs:** why I chose X over Y.

**AI workflow:** asked … | right … | wrong/corrected … | verified with …

**Definition of Done:** which criteria are met / outstanding.
```

## Incident / postmortem entry
```markdown
## YYYY-MM-DD — Incident: <name>

**Impact:** who/what was affected, for how long.
**Timeline:** HH:MM events reconstructed from evidence.
**Root cause:** the actual cause (not the symptom).
**Resolution:** what fixed it.
**Evidence:** commands + key output.
**Prevention / guardrail:** what stops recurrence.
```

## Environment entry (reproducibility)
```markdown
## YYYY-MM-DD — Environment

**Provisioning path:** (WSL/VM/cloud/container) + exact steps.
**OS / kernel:** output of `cat /etc/os-release` + `uname -r`.
**Baseline tools installed:** …
**How a teammate rebuilds this:** numbered steps.
```
