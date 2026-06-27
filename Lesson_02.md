# Lesson 2 — Recover the Lost Project

> **Competency:** File Management
> **Estimated time:** 2–3 hours

---

## 🎫 Engineering Ticket

```
TICKET:    INFRA-1077
TITLE:     Reconstruct a developer's project from scattered backup fragments
PRIORITY:  P1
DESCRIPTION:
A departing developer left a tarball of their home directory and a mess of
loose files in /tmp. Product needs the "checkout-service" project rebuilt
into a clean, conventional layout so a new owner can take it over. Files are
duplicated, misnamed, and scattered. Rebuild it carefully — losing the only
copy of a file is unacceptable.

ACCEPTANCE CRITERIA:
- A clean project tree under ~/projects/checkout-service.
- Source, config, and docs separated into conventional subdirectories.
- An archive (.tar.gz) of the rebuilt project as a restore point.
- A manifest listing every file and where it came from.
```

---

## 🎯 Learning Objectives

1. Create, copy, move, rename, and delete files and directories safely.
2. Use wildcards/globbing (`*`, `?`, `[...]`, `{...}`) to act on many files.
3. Create and extract archives with `tar` and compress with `gzip`.
4. Use `find` to locate files by name, type, size, and time.
5. Apply *defensive* file operations (`-i`, `cp -a`, dry runs) to avoid data loss.

---


## 🧭 Beginner Map

### Big idea
File management is careful movement. Engineers often need to reorganize messy files, but every copy, move, or delete should be deliberate and reversible.

### Key vocabulary
- **Globbing:** The shell expanding patterns like `*.py` into matching filenames.
- **Archive:** One file that bundles many files together.
- **Checksum:** A fingerprint used to compare file contents.
- **Dry run:** A safe preview before doing the real action.
- **Metadata:** Information about a file, such as permissions and timestamps.

### Mental model
Imagine cleaning a messy backpack before turning in a project. You first spread everything out, group related items, remove duplicates only when you are sure, then zip the final folder as a backup.

### How to study this lesson
1. Read the ticket as a story first: what problem needs solving?
2. Learn the vocabulary before memorizing commands.
3. Predict what each command will show before running it.
4. Run the command, compare the output to your prediction, and write one sentence about what changed in your understanding.

## 📚 Technical Deep Dive

### The core verbs

```bash
mkdir -p projects/checkout-service/{src,config,docs}  # -p makes parents
cp -a source/ dest/      # archive mode: preserves perms, times, links
mv old.txt new.txt       # rename (move within same dir)
rm -i file               # interactive: ask before each delete
rmdir emptydir           # only removes EMPTY dirs (safe)
```

`mv` is both "move" and "rename" — there is no separate rename command.
`cp -a` (or `-rp`) is the safe default for copying trees because it
preserves ownership, permissions, and timestamps.

### Globbing: the shell expands it, not the command

When you type `rm *.log`, the **shell** expands `*.log` into a list of
matching files *before* `rm` ever runs. This is why a stray space in
`rm -rf / tmp/cache` is catastrophic — it becomes `rm -rf /` plus
`tmp/cache`. Globs:

| Pattern   | Matches                                    |
|-----------|--------------------------------------------|
| `*`       | any number of characters                   |
| `?`       | exactly one character                      |
| `[abc]`   | one of a, b, or c                          |
| `{a,b}`   | brace expansion → `a` and `b`              |

### Archives with tar

`tar` (tape archive) bundles many files into one; `gzip` compresses. The
mnemonic for **c**reate: `tar -czf` = **c**reate **z**ip **f**ile. For
e**x**tract: `tar -xzf`.

```bash
tar -czf checkout-service.tar.gz checkout-service/   # create
tar -tzf checkout-service.tar.gz                     # list (verify!)
tar -xzf checkout-service.tar.gz                     # extract
```

Always **list** (`-t`) before you extract into a real directory.

### find: the search workhorse

```bash
find . -name '*.py'              # by name
find . -type f -size +1M         # files over 1 MB
find . -type d -empty            # empty directories
find . -newermt '2025-01-01'     # modified after a date
find . -name '*.tmp' -delete     # act on matches (careful!)
```

---


## 🔎 Guided Command Reading

Before any command with `rm`, `mv`, `cp`, or `find ... -delete`, run a preview command first. For example, run `printf '%s
' *.py` to see what the shell will expand before using those matches.

When you see a command in this lesson, break it into three parts:

1. **Program:** the command being run, such as `ls`, `grep`, or `systemctl`.
2. **Options:** flags that change behavior, such as `-l`, `-h`, or `--since`.
3. **Target:** the file, directory, service, host, or text the command acts on.

Write the command in your notebook, then add: **What I expected**, **What happened**, and **What I think it means**.

## ⚠️ Common Beginner Mistakes

- Assuming `*.py` is passed to `cp`; the shell expands it first.
- Deleting duplicates by filename instead of comparing contents.
- Creating an archive but never listing it with `tar -tzf` to verify it.

## 🧠 Check Your Understanding

Before starting the assignment, answer these in your own words:

- What does `main?.py` match that `main*.py` might not?
- Why is `cp -a` safer than plain `cp` for a project tree?
- What should you do before extracting an unfamiliar tarball?

## 🧪 Hands-on Labs

> See [`labs/lab-02-file-recovery.md`](labs/lab-02-file-recovery.md), which
> ships a script to generate the "scattered" project mess.

**Lab 2.1 — Build the target tree** with `mkdir -p` and brace expansion.

**Lab 2.2 — Locate fragments** with `find`, then `cp -a` them into place.

**Lab 2.3 — De-duplicate** using `find ... -exec` and checksums (`md5sum`).

**Lab 2.4 — Archive** the result and verify with `tar -tzf`.

---

## 📝 Assignment

Rebuild the provided scattered project into `~/projects/checkout-service`
with `src/`, `config/`, and `docs/`. Produce `MANIFEST.md` mapping each
final file to its origin, and a verified `.tar.gz` restore point. Commit
referencing `INFRA-1077`.

---

## 🤖 AI Engineering Exercise

Describe your scattered files to an AI and ask it to propose a `find` +
`cp` strategy. **Verify before running**: run each `find` with no action
first to see what it *would* match. Record in your notebook any case where
the AI's command would have copied or deleted the wrong files.

---

## 🪞 Reflection

- When did defensive flags (`-i`, dry-run `find`) save you?
- Why does the shell — not `rm` — expand the `*`?
- What would you automate if you had to do this 100 times?

---

## ✅ Definition of Done

- [ ] Clean `checkout-service` tree with conventional subdirectories.
- [ ] `MANIFEST.md` maps every file to its source.
- [ ] Verified `.tar.gz` restore point exists.
- [ ] No file was lost; duplicates resolved deliberately.
