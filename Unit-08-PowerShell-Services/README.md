# Unit 08 - PowerShell Service Management

## Overview
Used PowerShell to export all running services to a text file
and wrote a script to stop and start the Print Spooler service.

## What Was Asked
1. Create a PowerShell script that exports all running services to a txt file
2. Write a script that stops and starts the Print Spooler service

## Scripts

| Script | Description |
|--------|-------------|
| [01-get-running-services.ps1](scripts/01-get-running-services.ps1) | Exports all running services to a txt file |
| [02-restart-print-spooler.ps1](scripts/02-restart-print-spooler.ps1) | Stops and starts the Print Spooler service |

## What I Learned
- Get-Service returns all services  piping through Where-Object
  filters to only running ones
- Format-Table with Out-String converts the output to readable
  text before writing to a file
- The Print Spooler must be fully stopped before restarting 
  Start-Sleep gives it time to stop cleanly
- Stop-Service needs -Force if dependent services are running
