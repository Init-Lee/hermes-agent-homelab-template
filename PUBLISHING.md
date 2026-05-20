# Publishing Checklist

## Versioning Rules

### English (SemVer)

- **v0.1.0** — initial public template release
- **PATCH** — typo fixes, wording improvements, minor script comments, non-breaking documentation updates
- **MINOR** — new docs, new templates, new scripts, new safety checks, new workflow modules
- **MAJOR** — breaking changes to workspace layout, security assumptions, setup process, or script behavior

### 中文版本语义

- **v0.1.0** — 首次公开模板发布
- **v0.1.x** — 修错别字、补说明、轻微脚本注释
- **v0.2.0** — 新增文档、模板、脚本、检查项
- **v1.0.0** — 形成稳定范式，目录结构、安全规则和安装流程基本定稿
- **v2.0.0** — 破坏性调整，如工作区结构、安全边界、脚本行为发生重大变化

## Release Checklist

Before tagging a release, confirm:

- [ ] No secrets (API keys, tokens, SSH private keys, real `.env`, personal logs)
- [ ] README reviewed
- [ ] SECURITY.md reviewed
- [ ] LICENSE present (MIT)
- [ ] Scripts executable where needed (`chmod +x scripts/*.sh`)
- [ ] Smoke test prompts included
- [ ] Git status clean before tagging
- [ ] Tag release with annotated tag (`git tag -a`)

## Pre-release Security Scan

```bash
grep -RIn "API_KEY\|TOKEN\|SECRET\|PASSWORD\|PRIVATE KEY\|sk-\|ghp_\|AKIA" . \
  --exclude-dir=.git || true

find . -name '.env' -o -name '*.pem' -o -name '*.key' -o -name '*.log'
```

Also confirm that personal usernames, hostnames, IPs, and logs are removed or generalized.

## Push to GitHub

```bash
git init
git branch -M main
git remote add origin git@github.com:Init-Lee/hermes-agent-homelab-template.git
git add .
git commit -m "Initial Hermes Agent homelab template"
git push -u origin main
```

If remote origin already exists but points elsewhere:

```bash
git remote set-url origin git@github.com:Init-Lee/hermes-agent-homelab-template.git
```

HTTPS alternative:

```bash
git remote add origin https://github.com/Init-Lee/hermes-agent-homelab-template.git
git push -u origin main
```

## Tag Release

Use an **annotated tag**:

```bash
git tag -a v0.1.0 -m "v0.1.0 initial public template release"
git push origin v0.1.0
```

Release title:

```text
v0.1.0 - Initial Hermes Agent Homelab Template
```

## GitHub Repository Metadata

Requires `gh auth login` first:

```bash
gh repo edit Init-Lee/hermes-agent-homelab-template \
  --description "A safety-first Ubuntu homelab template for raising a local Hermes Agent: workspace design, boundary rules, setup flow, smoke tests, and long-term backup strategy." \
  --add-topic hermes-agent \
  --add-topic ai-agent \
  --add-topic homelab \
  --add-topic ubuntu \
  --add-topic local-agent \
  --add-topic agent-safety \
  --add-topic self-hosted \
  --add-topic automation \
  --add-topic workspace-template
```

Suggested repository description:

```text
A safety-first Ubuntu homelab template for raising a local Hermes Agent: workspace design, boundary rules, setup flow, smoke tests, and long-term backup strategy.
```

Suggested topics:

```text
hermes-agent, ai-agent, homelab, ubuntu, local-agent, agent-safety, self-hosted, automation, workspace-template
```
