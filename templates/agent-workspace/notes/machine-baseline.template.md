# Machine Baseline

## Identity

- User: `<linux-user>`
- Hostname: `<hostname>`
- SSH LAN IP: `<lan-ip>`
- Main NIC: `<network-interface>`

## System Disk

- Disk: `<system-disk>`
- Model: `<system-disk-model>`
- Ubuntu root: `<root-partition>`
- Root mount: `/`
- Root filesystem: `<filesystem>`
- Root size: `<size>`
- Root used: `<used-percent>`

## Other Partitions

- `<partition>`: `<filesystem>`, `<size>`, `<purpose>`

## HDDs / Data Disks

- `<disk-1>`: `<model>`, `<size>`, SMART `<status>`
- `<disk-2>`: `<model>`, `<size>`, SMART `<status>`

## Security

- SSH: `<active/inactive>`
- UFW: `<active/inactive>`
- UFW default incoming: `<deny/allow>`
- UFW default outgoing: `<deny/allow>`
- SSH port 22: `<allowed/not allowed>`

## Agent Workspace

- Main workspace: `/srv/agent-workspace`
- Owner: `<linux-user>`
- Subdirectories:
  - projects
  - scripts
  - notes
  - sandbox
  - logs

## Current Stage

- Hermes / agent: `<not installed / installed / setup complete>`
- RAID1: `<not created / created>`
- Backup workflow: `<not configured / configured>`
