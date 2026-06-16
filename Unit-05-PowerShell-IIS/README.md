# Unit 05 - PowerShell IIS Automation

## Overview
Automated the IIS installation, HTML file creation, and deployment
process using PowerShell scripts instead of manual GUI steps.

## What Was Asked
1. Write a PowerShell script to install IIS
2. Write a PowerShell script to create index.html containing your first name
3. Write a PowerShell script to copy index.html to the IIS default
   directory and restart IIS services

## What I Did
## Scripts

| Script | Description |
|--------|-------------|
| [01-install-iis.ps1](scripts/01-install-iis.ps1) | Installs IIS web server role |
| [02-create-index.ps1](scripts/02-create-index.ps1) | Creates index.html with name and course number |
| [03-deploy-restart-iis.ps1](scripts/03-deploy-restart-iis.ps1) | Deploys index.html to IIS root and restarts IIS |

## What I Learned
- PowerShell can fully automate IIS setup without touching the GUI
- Here-strings (@" "@) are the cleanest way to write multi-line
  HTML content inside a PowerShell script
- Restarting W3SVC is enough to apply changes — no full server
  restart needed
- Scripts must be run as Administrator or they will fail silently

## Troubleshooting
No issues encountered. Everything completed successfully on the first attempt.

## If I Did This Again
- Combine all three scripts into a single pipeline script with
  error handling using -ErrorAction Stop so it fails fast and
  clearly if anything goes wrong
- Use EC2 User Data to run the full script automatically on
  first boot so the server is ready before the first RDP connection