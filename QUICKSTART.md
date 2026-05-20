# Quickstart

## 1. 基础工具

```bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y git curl wget vim nano htop tmux unzip rsync ufw smartmontools build-essential ca-certificates
```

## 2. SSH 与 UFW

```bash
sudo systemctl is-active ssh
hostname -I
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status verbose
```

## 3. 创建 workspace

```bash
sudo mkdir -p /srv/agent-workspace/{projects,scripts,notes,sandbox,logs}
sudo chown -R "$USER:$USER" /srv/agent-workspace
```

## 4. 复制模板

```bash
cp templates/agent-workspace/README.md /srv/agent-workspace/README.md
cp templates/agent-workspace/notes/agent-operating-rules.md /srv/agent-workspace/notes/agent-operating-rules.md
cp templates/agent-workspace/notes/machine-baseline.template.md /srv/agent-workspace/notes/machine-baseline.md
cp scripts/check-base.sh /srv/agent-workspace/scripts/check-base.sh
cp scripts/start-hermes.sh /srv/agent-workspace/scripts/start-hermes.sh
chmod +x /srv/agent-workspace/scripts/*.sh
```

## 5. 检查基础状态

```bash
/srv/agent-workspace/scripts/check-base.sh
```

## 6. 安装 Hermes

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash -s -- --skip-setup
source ~/.bashrc
which hermes
hermes --version
hermes doctor
```

## 7. Setup 推荐值

- Terminal backend：Local
- Tool progress mode：all
- Max iterations：90
- Context compression threshold：0.70–0.75
- Context reset：Inactivity + daily reset
- Messaging platforms：先跳过
- Web Search provider：先跳过
- Image Generation：先跳过
- Browser provider：Local Browser
- TTS：默认免费免 key 方案

## 8. 验收

```bash
cd /srv/agent-workspace
hermes
```

然后依次执行 README 中的两个 smoke test 提示词。
