<#
.SYNOPSIS
This script configures the maximum size of the Windows System Event Log to 32768 KB via Local Group Policy according to STIG WN10-AU-000510.

.NOTES
Author       : Blessing Dominic Nze
Date Created : 2025-09-17
Version      : 1.0
STIG-ID      : WN10-AU-000510
#>

# Define the GPO registry key path for System Event Log
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$valueData = 32768  # 0x00008000 in hexadecimal

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the MaxSize value
Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord
Write-Host "Group Policy: '$valueName' set to '$valueData' at '$regPath'."

# Force GPUpdate to apply the policy
Write-Host "Applying Local Group Policy changes..."
gpupdate /force | Out-Null

# Verification
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName
if ($currentValue -ge $valueData) {
    Write-Host "PASS: System Event Log maximum size is configured correctly via Local GPO ($currentValue KB)."
} else {
    Write-Host "FAIL: System Event Log maximum size is NOT configured correctly ($currentValue KB)."
}
