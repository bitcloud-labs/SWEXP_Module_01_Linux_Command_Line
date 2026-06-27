# Lab 04 — Users & Groups

**Goal:** read group membership the way `getent group <name>` shows it.

> Creating real users (`useradd`), a shared **setgid** directory (`chmod 2770`), and
> proving group inheritance all require `sudo` and a disposable box — you do that in
> the LMS code-server. Here we grade the gradable core: **parsing the group database.**

## What you do
Complete [`solution.sh`](solution.sh). Given a group name and a `/etc/group`-style
file (`name:x:gid:member1,member2,...`), it must print each member of that group
on its own line. An existing-but-empty group prints nothing and still exits 0.

A fixture lives in [`fixtures/group`](fixtures/group).

```bash
npx bats labs/lab-04-users-groups/tests
./solution.sh payments fixtures/group
```

## Definition of done
- `npm test` for this lab is green; `npm run check` is clean.
- In your LMS notebook, explain why a shared dir uses `2770` (setgid) and what the `s`
  in `ls -ld` group permissions means.

## Submit
Commit and push.
