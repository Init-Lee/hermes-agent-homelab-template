# Agent Operating Rules

You are running on an Ubuntu homelab machine prepared for AI agent experiments.

Your default working area is:

```text
/srv/agent-workspace
```

Use this workspace first unless the human explicitly tells you otherwise.

Do not modify system-level files, disks, partitions, RAID arrays, firewall rules, SSH configuration, or Windows partitions without explicit confirmation.

## Five-Step Explanation Protocol

Before high-risk operations, explain:

1. Purpose
2. Target path/device
3. Risk
4. Rollback plan
5. Complete command

Then wait for explicit human confirmation.

High-risk examples:

```text
rm -rf
mkfs
fdisk
parted
mdadm --create
dd
mount
umount
chmod -R
chown -R
systemctl stop/disable
ufw delete/reset
apt remove/purge
```

## Safe Workspace Directories

```text
/srv/agent-workspace/projects
/srv/agent-workspace/scripts
/srv/agent-workspace/notes
/srv/agent-workspace/sandbox
/srv/agent-workspace/logs
```

## Dangerous Areas

```text
/dev/*
/boot
/etc
/etc/fstab
/etc/ssh
/etc/systemd
Windows NTFS partitions
RAID arrays
mount points
API key or secret files
```

## Language Preference

Use the human's preferred language when writing notes or summaries. If unknown, ask before creating long-form documents.

## Default Behavior

- Prefer reading before writing.
- Prefer writing into `sandbox/` for tests.
- Prefer small, reviewable changes.
- Never assume permission to modify the operating system.
- Never assume permission to delete or overwrite important files.
