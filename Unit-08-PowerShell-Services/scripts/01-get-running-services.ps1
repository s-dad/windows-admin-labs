# Export all running services to a txt file

Get-Service | Where-Object { $_.Status -eq 'Running' } |
  Select-Object Name, DisplayName, Status |
  Format-Table -AutoSize |
  Out-String |
  Out-File -FilePath "C:\RunningServices.txt" -Encoding UTF8

Write-Host "Running services saved to C:\RunningServices.txt" -ForegroundColor Green