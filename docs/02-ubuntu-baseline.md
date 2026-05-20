# Ubuntu Baseline

## 基础检查

```bash
whoami
hostname
hostname -I
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL
df -h /
```

## SSH

```bash
sudo systemctl status ssh
sudo systemctl is-active ssh
```

## UFW

```bash
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status verbose
```

推荐：

```text
Status: active
Default: deny (incoming), allow (outgoing)
OpenSSH ALLOW IN
```

## SMART

```bash
sudo smartctl -a /dev/sda | head -n 40
sudo smartctl -a /dev/sdb | head -n 40
sudo smartctl -a /dev/nvme0n1 | head -n 40
```

注意：必须根据自己的 `lsblk` 输出确认设备名。
