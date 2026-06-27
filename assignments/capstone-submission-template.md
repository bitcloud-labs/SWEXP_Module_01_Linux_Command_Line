# CAPSTONE-SUBMISSION.md — Template

```markdown
# CAP-9000 Capstone Submission

**Repo:** <git URL>   **Release tag:** v1.0-capstone

## Criterion → evidence map
| Acceptance criterion | File / command | Status |
|----------------------|----------------|--------|
| provision.sh idempotent & shellcheck-clean | provision.sh; `shellcheck provision.sh` | ✅ |
| Demo service running/enabled | `systemctl status demo` | ✅ |
| SSH key-only, no root/password | SECURITY.md; `sshd -t` | ✅ |
| Packages patched; scoped sudo | package-audit; /etc/sudoers.d/* | ✅ |
| Backup + retention + rotation + health check | RUNBOOK.md; `systemctl list-timers` | ✅ |
| Docs complete | README / RUNBOOK / SECURITY | ✅ |
| Clean Git history | `git log --oneline` | ✅ |
| Recovery scenario | postmortem in notebook | ✅ |
| AI verification logged | notebook "AI workflow" | ✅ |

## Fresh-box provision proof
\`\`\`
<paste the output of a clean ./provision.sh run on a new box>
\`\`\`

## AI workflow summary
Where AI helped, what it got wrong, how I caught it.

## Known limitations / next steps
What you'd improve with more time.
```
