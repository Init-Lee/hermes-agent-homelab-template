#!/usr/bin/env bash
set -e

echo "== Identity =="
whoami
hostname
hostname -I || true

echo
echo "== SSH =="
if systemctl list-unit-files | grep -q '^ssh\.service'; then
  systemctl is-active ssh || true
else
  echo "ssh.service not found"
fi

echo
echo "== UFW =="
if command -v ufw >/dev/null 2>&1; then
  sudo ufw status verbose || true
else
  echo "ufw not installed"
fi

echo
echo "== Disk Layout =="
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL

echo
echo "== Root Usage =="
df -h /

echo
echo "== Workspace =="
if [ -d /srv/agent-workspace ]; then
  ls -la /srv/agent-workspace
else
  echo "/srv/agent-workspace not found"
fi
