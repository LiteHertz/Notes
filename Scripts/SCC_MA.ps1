# Check if current process has Administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Requesting Administrator privileges..." -ForegroundColor Yellow
    
    # Re-launch the script with elevated rights
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    
    Write-Host "Script relaunched" -ForegroundColor Blue
    Read-Host "Press Enter to exit"
    exit
}


Write-Host "Running with Administrator rights" -ForegroundColor Green

try {
    Set-ExecutionPolicy Bypass -Scope Process -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Failed to set execution policy Bypass: $_"
}

$regPath = "HKLM:\SOFTWARE\Policies\Sinclair Community College\Make Me Admin"

if (-not (Test-Path $regPath)) {
    Write-Host "Registry path not found" -ForegroundColor Blue
    Read-Host "Press Enter to exit"
    exit
}

try {
    Set-ItemProperty -Path $regPath -Name "Admin Rights Timeout" -Value 1440 -Type DWORD -ErrorAction SilentlyContinue
    Write-Host "Admin Rights Timeout set"
} catch {
    Write-Host "Failed to set Admin Rights Timeout: $_"
}

try {
    Set-ItemProperty -Path $regPath -Name "Remove Admin Rights On Logout" -Value 0 -Type DWORD -ErrorAction SilentlyContinue
    Write-Host "Remove Admin Rights On Logout set to false"
} catch {
    Write-Host "Failed to set Remove Admin Rights On Logout: $_"
}

try {
    Set-ItemProperty -Path $regPath -Name "Override Removal By Outside Process" -Value 0 -Type DWORD -ErrorAction SilentlyContinue
    Write-Host "Override Removal By Outside Process set to false"
} catch {
    Write-Host "Failed to set Override Removal By Outside Process: $_"
}

try {
    Set-ItemProperty -Path $regPath -Name "Log Elevated Processes" -Value 0 -Type DWORD -ErrorAction SilentlyContinue
    Write-Host "Log Elevated Processes set to false"
} catch {
    Write-Host "Failed to set Log Elevated Processes: $_"
}

Write-Host "Script done" -ForegroundColor Blue
Read-Host "Press Enter to exit"
exit