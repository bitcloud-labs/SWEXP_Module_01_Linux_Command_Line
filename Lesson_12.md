# Lesson 12 — Secure the Software Supply Chain

> **Competency:** Package & Software Management
> **Estimated time:** 2–3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    SEC-2150
TITLE:     Audit and patch packages; stop installing from random scripts
PRIORITY:  P2
DESCRIPTION:
A scan flagged outdated packages with known CVEs, and we discovered someone
installed a tool via `curl | sudo bash`. Bring the system up to date safely,
inventory what's installed, remove an unnecessary package, and establish a
policy for trusted installation. Document what changed in case we need to
roll back.

ACCEPTANCE CRITERIA:
- System packages updated; security updates applied.
- An inventory of installed packages captured.
- One unneeded package removed cleanly.
- A documented "trusted install" policy replacing curl|bash.
```

---

## 🎯 Learning Objectives

1. Use `apt` to update, upgrade, search, install, and remove packages.
2. Understand repositories, package signing, and why they provide trust.
3. Inventory installed packages and inspect package contents/ownership.
4. Explain the risk of `curl | bash` and safer alternatives.
5. Apply security updates and capture a change record for rollback.

---


## 🧭 Beginner Map

### Big idea
Package managers help you install software with a chain of trust. They track versions, files, dependencies, and signatures so you are not running random code blindly.

### Key vocabulary
- **Package:** A bundled piece of software and metadata.
- **Repository:** A trusted source of packages.
- **Signature:** Cryptographic proof that a package came from a trusted source.
- **Dependency:** Software another package needs.
- **Inventory:** A list of what is installed.
- **Purge:** Remove a package and its configuration files.

### Mental model
A signed package repository is like buying lab equipment from an approved school supplier instead of accepting an unlabeled box from a stranger.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### Package managers exist to provide *trust*

A package manager like `apt` (Debian/Ubuntu) downloads software from
**signed repositories**. The signatures prove the package came from a
trusted source and wasn't tampered with in transit. That is the entire point
— it's a supply-chain security mechanism, not just a convenience.

```bash
sudo apt update                 # refresh the package index (does NOT upgrade)
sudo apt upgrade                # install available upgrades
sudo apt full-upgrade           # upgrades that may add/remove packages
apt search nginx                # find packages
sudo apt install --no-install-recommends htop
sudo apt remove --purge oldpkg  # remove + delete its config
sudo apt autoremove             # clean up orphaned dependencies
```
`apt update` refreshes *metadata*; `apt upgrade` actually installs. Running
`update` alone never changes installed software — a common point of confusion.

### Inventory and inspection

```bash
apt list --installed | wc -l        # how many packages?
dpkg -l | grep nginx                # is it installed, what version?
dpkg -L nginx                       # what files did this package install?
dpkg -S /usr/sbin/nginx             # which package owns this file?
apt-cache policy nginx              # candidate vs installed version
```

### Security updates specifically

```bash
sudo apt update
apt list --upgradable               # what's pending
# unattended-upgrades can auto-apply security patches
```

### Why `curl | sudo bash` is dangerous

`curl https://site/install.sh | sudo bash` runs **arbitrary unreviewed code
as root**, fetched over the network, with no signature, no version pin, and
no record of what it did. If the site is compromised (or MITM'd), you've
handed root to an attacker. Safer pattern: download, **read it**, pin a
version/checksum, then run:
```bash
curl -fsSLO https://site/install.sh
less install.sh            # actually read it
sha256sum install.sh       # compare to a published checksum
bash install.sh            # only after review
```
Better still: install from the distro repo or a vendor's signed repository.

---


## 🔎 Guided Command Reading

Separate `apt update` from `apt upgrade`: update refreshes the catalog; upgrade installs newer packages from that catalog.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Thinking `apt update` patched the system by itself.
- Running `curl | sudo bash` without reading or verifying the script.
- Removing a package without checking what depends on it or what files it owns.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- Which command tells you what package owns `/bin/ls`?
- Why does signing matter?
- What safer steps replace `curl | bash`?

## 🧪 Hands-on Labs

> See [`labs/lab-12-packages.md`](labs/lab-12-packages.md).

**Lab 12.1 — Update + list upgradable**; note any security updates.

**Lab 12.2 — Inventory**: count installed packages; find which package owns
`/bin/ls` with `dpkg -S`.

**Lab 12.3 — Install and inspect** a package; list its files with `dpkg -L`.

**Lab 12.4 — Remove + purge** an unneeded package and `autoremove` orphans.

---

## 📝 Assignment

Patch and audit your box. Submit `package-audit.md` with the before/after
package counts, the list of security updates applied, the package you
removed and why, and a one-paragraph "trusted install policy" that replaces
`curl | bash`. Commit referencing `SEC-2150`.

---

## 🤖 AI Engineering Exercise

Ask an AI how to install a specific tool. If it suggests `curl | bash`,
challenge it to provide a verifiable alternative (signed repo, checksum,
read-before-run). Document the safer procedure you settled on and why the
original suggestion was risky.

---

## 🪞 Reflection

- What's the real difference between `apt update` and `apt upgrade`?
- How does package signing protect you?
- When, if ever, is running a remote install script acceptable?

---

## ✅ Definition of Done

- [ ] Security updates applied; before/after recorded.
- [ ] Package inventory captured.
- [ ] One package removed and purged cleanly.
- [ ] Trusted-install policy documented.
