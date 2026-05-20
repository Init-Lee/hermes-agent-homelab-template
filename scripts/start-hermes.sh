#!/usr/bin/env bash
set -e

cd /srv/agent-workspace

echo "Starting Hermes from workspace:"
pwd

exec hermes
