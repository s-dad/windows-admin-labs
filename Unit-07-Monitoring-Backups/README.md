# Unit 07 - Monitoring and Backups

## Overview
Configured automatic OS updates, enabled AWS backups, verified
restart events in security logs, configured firewall rules for
ICMP traffic, and ran a vulnerability scan using Tenable Nessus
Essentials on Server 2.

## What Was Asked
1. Enable automatic OS updates on Server 2 to install every Tuesday at 3am
2. Enable automatic AWS backups for Server 2
3. Restart Server 2 and locate the restart event in the security logs
4. Configure firewall rules so Server 2 can ping Server 1
5. Scan Server 2 with Tenable Nessus Essentials for vulnerabilities

## What I Did

**Configured automatic OS updates:**
```powershell
# Set Windows Update to install every Tuesday at 3am
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Tuesday -At 3am
$action = New-ScheduledTaskAction -Execute "wuauclt.exe" -Argument "/detectnow /updatenow"

Register-ScheduledTask `
  -TaskName "Weekly Windows Update" `
  -Trigger $trigger `
  -Action $action `
  -RunLevel Highest `
  -Force
```
**Enabled automatic AWS backups:**

> AWS Console > AWS Backup > Create Backup Plan

| Setting | Value |
|---------|-------|
| Backup frequency | Daily |
| Backup window | Default |
| Retention period | 7 days |
| Resource | Server 2 |

