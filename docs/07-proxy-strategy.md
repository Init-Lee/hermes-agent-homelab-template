# Proxy Strategy

## 临时代理

```bash
export http_proxy=http://<proxy-host>:<port>
export https_proxy=http://<proxy-host>:<port>
export all_proxy=socks5h://<proxy-host>:<port>
export NO_PROXY=localhost,127.0.0.1,192.168.0.0/16
```

## 测试

```bash
curl -I https://github.com
curl -I https://raw.githubusercontent.com
git ls-remote https://github.com/NousResearch/hermes-agent.git HEAD
```

## 建议

不要在安装初期过早配置永久代理。等完成 Hermes 安装、setup、smoke test、RAID/backup 后，再单独治理长期代理。
