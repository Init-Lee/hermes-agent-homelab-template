# Hermes Agent Homelab Template

> English: [README.en.md](README.en.md)

一套面向 **Ubuntu 小主机 / Homelab / AI Agent 实验机** 的 Hermes Agent 部署与边界治理模板。

## 项目是什么

这不是“一键安装 Hermes”的炫技脚本，而是一套 **安全优先的本地 Agent 工作区范式**，沉淀以下内容：

- workspace 边界与目录结构
- Agent 操作规则（英文规则文件，供 Agent 直接读取）
- 基础检查脚本与 smoke test 提示词
- 备份策略与 RAID / 长期运维规划路径
- 代理策略与后续进阶能力路线图

核心问题：

> 如何让一个本地 Agent 有清晰的工作边界、目录结构、安全规则、验收流程与备份路径。

## 适合谁

- 在 Ubuntu 小主机或 Homelab 上运行本地 Hermes Agent 的用户
- 希望 Agent 有明确工作边界、而非默认获得系统权限的实验者
- 需要可复用模板来建立 `/srv/agent-workspace` 工作区的人
- 计划逐步引入 RAID1、备份、Docker 隔离、Gateway / Telegram 的自托管用户

## 解决什么问题

| 问题 | 本模板提供的方案 |
|---|---|
| Agent 活动范围不清晰 | `/srv/agent-workspace` 作为默认“马槽”边界 |
| 缺少操作约束 | `agent-operating-rules.md` 与 smoke test 验收 |
| 安装后不知如何验收 | 两条标准 smoke test 提示词 |
| 备份与 RAID 无从下手 | 分阶段文档 + 备份脚本模板 |
| 代理与长期运维缺规划 | 独立代理策略与 RAID 文档 |

## 推荐目录结构

```text
~/.hermes/                 # Hermes 自身配置、代码、记忆、sessions、logs
~/.local/bin/hermes         # Hermes 命令入口
/srv/agent-workspace/       # Agent 默认工作区，也就是“马槽”
/data/                      # 可选：RAID1 / NAS / 外部盘，用于备份与归档
```

一句话：

> Hermes 不需要全部装进 `/srv/agent-workspace`。  
> `/srv/agent-workspace` 是它被允许工作的默认边界，而不是程序安装目录。

工作区内部结构：

```text
/srv/agent-workspace
├── projects/   # 长期项目与代码仓库
├── scripts/    # 工具脚本与维护脚本
├── notes/      # 机器笔记、计划、记录
├── sandbox/    # 临时实验；安全的试错区域
└── logs/       # 脚本或 Agent 任务产生的日志
```

## 推荐阶段

| 阶段 | 目标 | 风险 |
|---|---|---|
| 0. 机器基线 | 确认用户、主机名、磁盘、SSH、UFW | 低 |
| 1. 建立马槽 | 创建 `/srv/agent-workspace` 与规则文件 | 低 |
| 2. 安装 Hermes | 安装到 `~/.hermes` | 中低 |
| 3. Full setup | 配置模型、工具、上下文策略 | 中低 |
| 4. Smoke test | 读取 README/rules，写入 sandbox 测试文件 | 低 |
| 5. 数据仓库 | RAID1、备份、归档、冷数据管理 | 高 |
| 6. 进阶能力 | Docker、Gateway、Telegram、长期代理、Skills Hub | 中高 |

## 快速开始

完整逐步指南见 [QUICKSTART.md](QUICKSTART.md)。

**1. 创建工作区**

```bash
sudo mkdir -p /srv/agent-workspace/{projects,scripts,notes,sandbox,logs}
sudo chown -R "$USER:$USER" /srv/agent-workspace
```

**2. 复制模板**

```bash
cp templates/agent-workspace/README.md /srv/agent-workspace/README.md
cp templates/agent-workspace/notes/agent-operating-rules.md /srv/agent-workspace/notes/agent-operating-rules.md
cp templates/agent-workspace/notes/machine-baseline.template.md /srv/agent-workspace/notes/machine-baseline.md
cp scripts/check-base.sh /srv/agent-workspace/scripts/check-base.sh
cp scripts/start-hermes.sh /srv/agent-workspace/scripts/start-hermes.sh
chmod +x /srv/agent-workspace/scripts/*.sh
```

**3. 安装 Hermes**

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash -s -- --skip-setup
source ~/.bashrc
which hermes
hermes --version
hermes doctor
```

**4. Full setup 与启动**

```bash
cd /srv/agent-workspace
hermes setup
hermes
```

## Smoke test 提示词

详见 [scripts/smoke-test-prompts.md](scripts/smoke-test-prompts.md)。

**边界读取测试：**

```text
请读取 /srv/agent-workspace/README.md 和 /srv/agent-workspace/notes/agent-operating-rules.md，概括你在这台机器上的默认工作边界、允许操作范围、禁止操作范围。不要执行任何系统修改命令。
```

**Sandbox 写入测试：**

```text
请在 /srv/agent-workspace/sandbox 里创建一个 hello-hermes.md，内容写明：1）当前测试时间；2）当前工作目录；3）你理解的三条安全边界。只允许写这个文件，不要修改其他文件，不要执行系统级修改命令。
```

## 安全边界

Agent 可以帮你做事，但不应默认获得 root 权威。

涉及以下内容时必须人工确认：

- `/dev/*`
- 分区、格式化、RAID、挂载
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
- API key / secret 文件

完整安全策略见 [SECURITY.md](SECURITY.md)。

## 免责声明

- **本仓库不包含任何 API Key、token 或真实凭据**，仅提供泛化模板与占位符。
- **本仓库不代替 [Hermes 官方文档](https://github.com/NousResearch/hermes-agent)**。安装、配置与升级 Hermes 请以官方仓库为准。
- 高风险操作（磁盘、RAID、防火墙、SSH 等）必须人工审核后再执行。

## 后续路线

| 方向 | 说明 | 文档 |
|---|---|---|
| RAID1 | 冷数据盘阵列与挂载规划 | [docs/06-raid-and-backup-strategy.md](docs/06-raid-and-backup-strategy.md) |
| 备份 | Hermes 配置与数据定期归档 | [docs/06-raid-and-backup-strategy.md](docs/06-raid-and-backup-strategy.md) |
| 长期代理 | HTTP/SOCKS 代理策略与 NO_PROXY 规划 | [docs/07-proxy-strategy.md](docs/07-proxy-strategy.md) |
| Docker 隔离 | 后期引入容器级沙箱 | 阶段 6（待扩展） |
| Gateway / Telegram | 远程接入与消息平台 | 阶段 6（待扩展） |

## 文档索引

| 文档 | 内容 |
|---|---|
| [README.en.md](README.en.md) | 英文说明 |
| [QUICKSTART.md](QUICKSTART.md) | 逐步安装与验收 |
| [docs/01-concept.md](docs/01-concept.md) | 马槽、热数据、冷数据与 Agent 边界 |
| [docs/02-ubuntu-baseline.md](docs/02-ubuntu-baseline.md) | Ubuntu 机器基线 |
| [docs/03-hermes-install.md](docs/03-hermes-install.md) | Hermes 安装 |
| [docs/04-hermes-setup-recommendations.md](docs/04-hermes-setup-recommendations.md) | Setup 推荐值 |
| [docs/05-smoke-test.md](docs/05-smoke-test.md) | Smoke test 详解 |
| [docs/06-raid-and-backup-strategy.md](docs/06-raid-and-backup-strategy.md) | RAID 与备份策略 |
| [docs/07-proxy-strategy.md](docs/07-proxy-strategy.md) | 代理策略 |
| [scripts/smoke-test-prompts.md](scripts/smoke-test-prompts.md) | Smoke test 提示词 |
| [PUBLISHING.md](PUBLISHING.md) | 版本规则与发布 checklist |
| [SECURITY.md](SECURITY.md) | 安全策略 |

## License

MIT License. See [LICENSE](LICENSE).
