# Hermes Installation

## 安装

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash -s -- --skip-setup
source ~/.bashrc
which hermes
hermes --version
hermes doctor
```

## PATH warning

如果出现：

```text
~/.local/bin is not on your PATH
```

处理：

```bash
grep -q 'HOME/.local/bin' ~/.bashrc || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## GitHub 网络失败

临时代理：

```bash
export http_proxy=http://<proxy-host>:<port>
export https_proxy=http://<proxy-host>:<port>
export all_proxy=socks5h://<proxy-host>:<port>
```

测试：

```bash
curl -I https://github.com
git ls-remote https://github.com/NousResearch/hermes-agent.git HEAD
```

如果 clone 留下半截目录：

```bash
rm -rf ~/.hermes/hermes-agent
```
