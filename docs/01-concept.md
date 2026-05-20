# Concept：马槽、热数据、冷数据与 Agent 边界

- **Hermes / Agent**：马。
- **Ubuntu 小主机**：马厩。
- **`/srv/agent-workspace`**：马槽，即默认允许活动的范围。
- **SSD**：热工作区，适合正在运行和频繁修改的内容。
- **RAID1 / NAS / 外部盘**：冷数据仓库，适合归档和备份。
- **Git**：版本簿，适合代码、文档和模板。

## 目录逻辑

```text
~/.hermes/ = Hermes 自己的家
/srv/agent-workspace/ = Hermes 干活的地方
/data/ = 冷数据、备份、归档
```

## 马槽不是绝对监狱

`/srv/agent-workspace` 是默认边界和行为约束，不是强制内核级沙箱。

如果需要强隔离，后期再引入：

- Docker backend
- 独立 Linux 用户
- systemd sandbox
- AppArmor
- 只读挂载
