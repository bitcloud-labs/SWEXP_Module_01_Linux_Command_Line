# Lab 02 — File Recovery (Lesson 2)

## Goal
Rebuild a scattered project into a clean, conventional tree.


## How to Learn From This Lab

Use the **predict → run → explain** loop:

1. **Predict:** write what you think the command will do.
2. **Run:** execute exactly one step.
3. **Explain:** write what the output means in plain language.
4. **Verify:** use a second command or the filesystem state to prove the result.

## Beginner Checkpoints

- Predict what each glob will match before you run it.
- Use preview commands before every copy or delete.
- Challenge: add one extra duplicate and prove it is a duplicate using a checksum.

## Setup — generate the mess
```bash
mkdir -p ~/swexp-lab/l02/dump && cd ~/swexp-lab/l02/dump
echo "print('app')" > main.py
echo "print('app')" > main_COPY.py      # duplicate
echo "DEBUG=true" > settings.conf
echo "# Checkout Service" > readme.txt
echo "def pay(): pass" > payments.py
mkdir -p stray && mv payments.py stray/
```

## Tasks
1. **Target tree:** `mkdir -p ~/projects/checkout-service/{src,config,docs}`
2. **Find + place:**
   ```bash
   find ~/swexp-lab/l02/dump -name '*.py'   # preview matches first
   cp -a ~/swexp-lab/l02/dump/main.py ~/swexp-lab/l02/dump/stray/payments.py ~/projects/checkout-service/src/
   cp -a ~/swexp-lab/l02/dump/*.conf ~/projects/checkout-service/config/
   cp -a ~/swexp-lab/l02/dump/readme.txt ~/projects/checkout-service/docs/
   ```
3. **De-dupe by checksum:** `md5sum ~/swexp-lab/l02/dump/main*.py`
4. **Archive + verify:**
   ```bash
   cd ~/projects && tar -czf checkout-service.tar.gz checkout-service
   tar -tzf checkout-service.tar.gz
   ```

## Deliverable
The clean tree, `MANIFEST.md`, and a verified `.tar.gz`. Solution:
[`../solutions/lab-02-solution.md`](../solutions/lab-02-solution.md).
