#!/usr/bin/env bash
set -euo pipefail

BACKUP_ROOT="/data/hermes-backups"
SRC="$HOME/.hermes"
TS="$(date +"%Y%m%d-%H%M%S")"
DEST="$BACKUP_ROOT/hermes-$TS.tar.gz"

mkdir -p "$BACKUP_ROOT"

if [ ! -d "$SRC" ]; then
  echo "Hermes directory not found: $SRC" >&2
  exit 1
fi

tar \
  --exclude="$SRC/hermes-agent/.git" \
  --exclude="$SRC/logs/*.log" \
  -czf "$DEST" \
  "$SRC"

chmod 600 "$DEST"

find "$BACKUP_ROOT" -name "hermes-*.tar.gz" -mtime +30 -delete

echo "Backup completed: $DEST"
