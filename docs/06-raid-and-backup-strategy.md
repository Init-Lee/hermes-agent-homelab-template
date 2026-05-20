# RAID and Backup Strategy

## 推荐结构

```text
SSD:
  /srv/agent-workspace     # 热工作区
  ~/.hermes                # Hermes 活跃配置、记忆、sessions

RAID1 / NAS / external disk:
  /data/hermes-backups     # Hermes 定期备份
  /data/project-archives   # 项目归档
  /data/datasets           # 大型数据集
  /data/logs               # 日志归档
```

## RAID1 不是备份

RAID1 可以防单块硬盘损坏，但不能防：

- 误删
- 误改
- Agent 错误命令
- 整机损坏

## 高风险命令

执行前必须人工确认：

```text
mkfs
fdisk
parted
mdadm --create
dd
mount
umount
编辑 /etc/fstab
```

操作前必须展示：

```bash
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL
```
