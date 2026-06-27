# Labs

Each lab corresponds to a lesson and is meant to be done **on your own Linux
box**, not just read. Many labs ship a small `setup` snippet that generates a
realistic, safe scenario (fake logs, a crashing service, a scattered project)
so you practice on something that behaves like production without touching
production.

## Conventions

- Every lab starts by creating an isolated scratch directory so nothing
  outside it is affected: `mkdir -p ~/swexp-lab && cd ~/swexp-lab`.
- Destructive practice (kill, rm, fill disk) is confined to scratch dirs and
  bounded so it cannot harm the host.
- Record commands and output in your engineering notebook as you go. Use the **predict → run → explain** loop: predict what a command will do, run exactly one step, then explain the output in your own words before moving on.

## Lab index

| Lab | Lesson | Focus |
|-----|--------|-------|
| `lab-00-environment.md` | 0 | Provision + identify your box |
| `lab-01-filesystem-survey.md` | 1 | Filesystem orientation |
| `lab-02-file-recovery.md` | 2 | File management & archives |
| `lab-03-permissions.md` | 3 | Permissions & ownership |
| `lab-04-users-groups.md` | 4 | Users, groups, setgid |
| `lab-05-log-investigation.md` | 5 | grep/awk incident hunt |
| `lab-06-pipeline.md` | 6 | Pipes, redirection, report |
| `lab-07-dotfiles.md` | 7 | Shell environment & dotfiles |
| `lab-08-onboarding-script.md` | 8 | Robust Bash scripting |
| `lab-09-process-management.md` | 9 | Processes, signals, systemd |
| `lab-10-networking.md` | 10 | Connectivity & port audit |
| `lab-11-ssh.md` | 11 | SSH keys & hardening |
| `lab-12-packages.md` | 12 | Package audit & supply chain |
| `lab-13-scheduling.md` | 13 | cron, timers, logrotate |
| `lab-14-resources.md` | 14 | Disk/memory diagnosis |

> Solution keys for every lab are in [`../solutions/`](../solutions/).
> **Try the lab fully before opening the solution.**
