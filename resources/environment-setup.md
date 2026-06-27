# Environment Setup — Getting a Linux Box

You need a Linux environment you can break and rebuild. Pick the path that
matches your hardware and constraints. **Ubuntu 24.04 LTS** is assumed
throughout; other distros work but commands may differ slightly.

## Option A — Docker container (fastest, great for most labs)
```bash
docker run -it --name swexp ubuntu:24.04 bash
apt update && apt install -y sudo git curl iproute2 procps lsof
```
Re-enter later with `docker start -ai swexp`. Note: containers don't run a
full systemd by default, so a few service/timer labs are better on a VM.

## Option B — WSL2 (Windows)
```powershell
wsl --install -d Ubuntu
```
Full Linux userland integrated with Windows. systemd can be enabled in
`/etc/wsl.conf`. Excellent day-to-day choice on Windows laptops.

## Option C — Virtual machine (most realistic)
Install **Ubuntu Server 24.04** in VirtualBox (x86) or UTM (Apple Silicon).
Full systemd, networking, SSH — ideal for Lessons 9–14. Take a **snapshot**
after setup so you can roll back after destructive labs.

## Option D — Cloud instance
The smallest instance on any provider. Realistic networking and SSH. Remember
to stop/terminate it to avoid charges, and never expose it with password SSH.

## Recommended baseline tools
```bash
sudo apt update
sudo apt install -y git curl wget vim tree htop lsof iproute2 net-tools shellcheck
```

## Tip
Whatever you choose, **document how you built it** in your engineering
notebook (Lesson 0). Reproducibility is graded.
