<#
.SYNOPSIS
Disables the SMBv1 client driver (MrxSmb10) according to STIG WN10-00-000170.

.NOTES
Author : Blessing Dominic Nze
Date Created : 2025-09-17
Version : 1.0
STIG-ID : WN10-00-000170
#>

# Registry path for SMBv1 client driver
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"
$valueName = "Start"
$valueData = 4  # 4 = Disabled

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    Write-Host "Registry path does not exist. Creating path..."
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the driver to disabled
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

Write-Host "SMBv1 client driver (MrxSmb10) is now disabled. A restart is required for changes to take effect."
