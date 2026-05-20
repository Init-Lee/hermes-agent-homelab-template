# Security Policy

Do not commit:

- `.env`
- API keys
- OAuth tokens
- SSH private keys
- bot tokens
- provider credentials
- personal logs
- machine-specific sensitive configuration

High-risk operations must be manually reviewed:

- formatting disks
- creating RAID arrays
- mounting/unmounting filesystems
- editing `/etc/fstab`
- changing SSH configuration
- changing firewall rules
- deleting directories recursively
- changing ownership or permissions recursively
- stopping/disabling services
