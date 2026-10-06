$regPath = "HKLM:\SOFTWARE\Policies\Sinclair Community College\Make Me Admin"

if (-not (Test-Path $regPath)) {
    Write-Host "Path not found"
    Read-Host "Press Enter to exit"
    exit
}

try {
    Set-ItemProperty -Path $regPath -Name "Admin Rights Timeout" -Value 1440 -Type DWORD -ErrorAction Stop
    Write-Host "Admin Rights Timeout set"
} catch {
    Write-Host "Failed to set Admin Rights Timeout: $_"
}

try {
    Set-ItemProperty -Path $regPath -Name "Remove Admin Rights On Logout" -Value 0 -Type DWORD -ErrorAction Stop
    Write-Host "Remove Admin Rights On Logout set to false"
} catch {
    Write-Host "Failed to set Remove Admin Rights On Logout: $_"
}

try {
    Set-ItemProperty -Path $regPath -Name "Override Removal By Outside Process" -Value 0 -Type DWORD -ErrorAction Stop
    Write-Host "Override Removal By Outside Process set to false"
} catch {
    Write-Host "Failed to set Override Removal By Outside Process: $_"
}

try {
    Set-ItemProperty -Path $regPath -Name "Log Elevated Processes" -Value 0 -Type DWORD -ErrorAction Stop
    Write-Host "Log Elevated Processes set to false"
} catch {
    Write-Host "Failed to set Log Elevated Processes: $_"
}