# Stop and start the Print Spooler service

Stop-Service -Name Spooler -Force
Write-Host "Print Spooler stopped." -ForegroundColor Yellow

Start-Sleep -Seconds 2

Start-Service -Name Spooler
Write-Host "Print Spooler started." -ForegroundColor Green

(Get-Service -Name Spooler).Status