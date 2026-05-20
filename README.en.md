# Hermes Agent Homelab Template

> 中文说明请参阅 [README.md](README.md)

A safety-first Ubuntu homelab template for running a local Hermes Agent. It provides workspace boundaries, operating rules, setup flow, smoke tests, backup planning, and staged self-hosted agent workflows.

## What This Is

This is **not** a one-click Hermes installer. It is a **safety-first local Agent workspace pattern** that captures:

- Workspace boundaries and directory layout
- Agent operating rules (English rule files for Agent consumption)
- Baseline check scripts and smoke test prompts
- Backup strategy and RAID / long-term ops planning
- Proxy strategy and a staged roadmap for advanced capabilities

Core question:

> How do you give a local Agent clear workspace boundaries, directory structure, safety rules, acceptance flow, and a backup path?

## Who It Is For

- Users running a local Hermes Agent on an Ubuntu mini PC or homelab
- Experimenters who want explicit Agent boundaries instead of default system authority
- Anyone who needs a reusable template to bootstrap `/srv/agent-workspace`
- Self-hosters planning RAID1, backups, Docker isolation, Gateway / Telegram over time

## What Problems It Solves

| Problem | What this template provides |
|---|---|
| Unclear Agent activity scope | `/srv/agent-workspace` as the default "stall" boundary |
| Missing operating constraints | `agent-operating-rules.md` and smoke test acceptance |
| No post-install validation | Two standard smoke test prompts |
| Unsure how to start with backup / RAID | Staged docs + backup script template |
| No long-term proxy / ops plan | Dedicated proxy and RAID docs |

## Recommended Directory Layout

```text
~/.hermes/                 # Hermes config, code, memory, sessions, logs
~/.local/bin/hermes         # Hermes CLI entrypoint
/srv/agent-workspace/       # Agent default workspace ("stall")
/data/                      # Optional: RAID1 / NAS / external disk for backup & archive
```

In short:

> Hermes does not need to live entirely inside `/srv/agent-workspace`.  
> `/srv/agent-workspace` is the default allowed working boundary, not the install directory.

Workspace internals:

```text
/srv/agent-workspace
├── projects/   # Long-running projects and repositories
├── scripts/    # Utility and maintenance scripts
├── notes/      # Machine notes, plans, records
├── sandbox/    # Temporary experiments; safe trial area
└── logs/       # Logs from scripts or Agent tasks
```

## Recommended Stages

| Stage | Goal | Risk |
|---|---|---|
| 0. Machine baseline | Confirm user, hostname, disks, SSH, UFW | Low |
| 1. Create stall | Create `/srv/agent-workspace` and rule files | Low |
| 2. Install Hermes | Install to `~/.hermes` | Low–medium |
| 3. Full setup | Configure model, tools, context policy | Low–medium |
| 4. Smoke test | Read README/rules; write sandbox test file | Low |
| 5. Data store | RAID1, backup, archive, cold data | High |
| 6. Advanced | Docker, Gateway, Telegram, long-running proxy, Skills Hub | Medium–high |

## Quick Start

Full step-by-step guide: [QUICKSTART.md](QUICKSTART.md).

**1. Create workspace**

```bash
sudo mkdir -p /srv/agent-workspace/{projects,scripts,notes,sandbox,logs}
sudo chown -R "$USER:$USER" /srv/agent-workspace
```

**2. Copy templates**

```bash
cp templates/agent-workspace/README.md /srv/agent-workspace/README.md
cp templates/agent-workspace/notes/agent-operating-rules.md /srv/agent-workspace/notes/agent-operating-rules.md
cp templates/agent-workspace/notes/machine-baseline.template.md /srv/agent-workspace/notes/machine-baseline.md
cp scripts/check-base.sh /srv/agent-workspace/scripts/check-base.sh
cp scripts/start-hermes.sh /srv/agent-workspace/scripts/start-hermes.sh
chmod +x /srv/agent-workspace/scripts/*.sh
```

**3. Install Hermes**

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash -s -- --skip-setup
source ~/.bashrc
which hermes
hermes --version
hermes doctor
```

**4. Full setup and launch**

```bash
cd /srv/agent-workspace
hermes setup
hermes
```

## Smoke Test Prompts

See [scripts/smoke-test-prompts.md](scripts/smoke-test-prompts.md).

**Boundary reading test:**

```text
请读取 /srv/agent-workspace/README.md 和 /srv/agent-workspace/notes/agent-operating-rules.md，概括你在这台机器上的默认工作边界、允许操作范围、禁止操作范围。不要执行任何系统修改命令。
```

**Sandbox write test:**

```text
请在 /srv/agent-workspace/sandbox 里创建一个 hello-hermes.md，内容写明：1）当前测试时间；2）当前工作目录；3）你理解的三条安全边界。只允许写这个文件，不要修改其他文件，不要执行系统级修改命令。
```

## Safety Boundaries

An Agent can help you work, but it should not default to root authority.

The following require explicit human confirmation:

- `/dev/*`
- Partitioning, formatting, RAID, mounting
- `/etc/fstab`
- SSH / UFW / systemd
- `rm -rf`
- `mkfs`
- `fdisk`
- `parted`
- `mdadm --create`
- `dd`
- `chmod -R`
- `chown -R`
- API keys / secret files

Full policy: [SECURITY.md](SECURITY.md).

## Disclaimer

- **This repository contains no API keys, tokens, or real credentials** — only generalized templates and placeholders.
- **This repository does not replace the [official Hermes documentation](https://github.com/NousResearch/hermes-agent)**. Install, configure, and upgrade Hermes using the official repo.
- High-risk operations (disks, RAID, firewall, SSH, etc.) must be reviewed by a human before execution.

## Roadmap

| Direction | Description | Doc |
|---|---|---|
| RAID1 | Cold storage array and mount planning | [docs/06-raid-and-backup-strategy.md](docs/06-raid-and-backup-strategy.md) |
| Backup | Periodic archive of Hermes config and data | [docs/06-raid-and-backup-strategy.md](docs/06-raid-and-backup-strategy.md) |
| Long-term proxy | HTTP/SOCKS proxy and NO_PROXY planning | [docs/07-proxy-strategy.md](docs/07-proxy-strategy.md) |
| Docker isolation | Container-level sandbox (later) | Stage 6 (TBD) |
| Gateway / Telegram | Remote access and messaging platforms | Stage 6 (TBD) |

## Documentation Index

| Doc | Contents |
|---|---|
| [README.md](README.md) | Chinese documentation |
| [QUICKSTART.md](QUICKSTART.md) | Step-by-step install and acceptance |
| [docs/01-concept.md](docs/01-concept.md) | Stall, hot/cold data, Agent boundaries |
| [docs/02-ubuntu-baseline.md](docs/02-ubuntu-baseline.md) | Ubuntu machine baseline |
| [docs/03-hermes-install.md](docs/03-hermes-install.md) | Hermes installation |
| [docs/04-hermes-setup-recommendations.md](docs/04-hermes-setup-recommendations.md) | Setup recommendations |
| [docs/05-smoke-test.md](docs/05-smoke-test.md) | Smoke test details |
| [docs/06-raid-and-backup-strategy.md](docs/06-raid-and-backup-strategy.md) | RAID and backup strategy |
| [docs/07-proxy-strategy.md](docs/07-proxy-strategy.md) | Proxy strategy |
| [scripts/smoke-test-prompts.md](scripts/smoke-test-prompts.md) | Smoke test prompts |
| [PUBLISHING.md](PUBLISHING.md) | Versioning rules and release checklist |
| [SECURITY.md](SECURITY.md) | Security policy |

## License

MIT License. See [LICENSE](LICENSE).
