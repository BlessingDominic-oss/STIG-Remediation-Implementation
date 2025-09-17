<# 
.SYNOPSIS
This script disables the Windows Store on Windows 10 as per STIG WN10-00-000190.

.NOTES
Author : Blessing Dominic Nze
Date Created : 2025-09-17
Version : 1.0
STIG-ID : WN10-00-000190
#>

# Define the registry path and value
$registryPath = "HKLM:\Software\Policies\Microsoft\WindowsStore"
$valueName = "RemoveWindowsStore"
$valueData = 1

# Check if the registry path exists; if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set the RemoveWindowsStore value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Output success message
Write-Host "Registry value '$valueName' set to '$valueData' at '$registryPath'. Windows Store is now disabled."
