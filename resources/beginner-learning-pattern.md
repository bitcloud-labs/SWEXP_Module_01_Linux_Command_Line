# Beginner Learning Pattern — Predict → Run → Explain

This module uses professional engineering tickets, but you are not expected to
already think like a professional systems engineer. The way to build that skill
is to slow down and practice a repeatable learning loop.

## The loop

1. **Predict** — Before running a command, write what you think it will do.
2. **Run** — Run one command or one pipeline stage at a time.
3. **Explain** — Translate the output into plain language.
4. **Verify** — Use another command, file listing, log, or test to prove your
   explanation is correct.
5. **Record** — Put the command, output, and explanation in your engineering
   notebook.

## Command-reading checklist

For every new command, identify:

- **Program:** the command name, such as `ls`, `grep`, or `systemctl`.
- **Options:** flags that modify behavior, such as `-l`, `-h`, or `--since`.
- **Target:** the file, directory, process, service, host, or text being acted on.
- **Risk:** whether the command only observes or changes the system.
- **Proof:** how you will verify the command did what you think it did.

## Plain-language standard

A good explanation should be understandable to a classmate who is also new to
Linux. Start with ordinary language, then add the technical term.

Weak explanation:

> `chmod 640` sets the mode.

Stronger explanation:

> This makes the file readable and writable by the owner, readable by the group,
> and invisible to everyone else. The technical term is that the file mode is
> `640`.

## Notebook prompt

Use this mini-template during labs:

```markdown
### Command
`<command here>`

Prediction:

Output:

Explanation in my own words:

Verification:
```
