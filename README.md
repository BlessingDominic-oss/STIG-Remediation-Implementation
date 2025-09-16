<#
.SYNOPSIS
This PowerShell script configures the Windows Application event log to ensure its maximum size is at least 32 MB (32768 KB).

.NOTES
Author      : Blessing Dominic Nze  
LinkedIn    : linkedin.com/in/blessingdominicnze/  
GitHub      : https://github.com/BlessingDominic-oss  
Date Created: 2025-09-16  
Last Updated: 2025-09-16  
Version     : 1.0  
CVEs        : N/A  
Plugin IDs  : N/A  
STIG-ID     : WN10-AU-000500  

.TESTED ON
Date(s) Tested :  
Tested By      :  
Systems Tested :  
PowerShell Ver.:  

.USAGE
Example execution:  
PS C:\> .\STIG-ID-WN10-AU-000500.ps1  
#>

# Define registry location and required value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName    = "MaxSize"
$valueData    = 32768   # Equivalent to 0x00008000 in hexadecimal

# Create registry path if missing
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Apply the MaxSize setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Verify that the value was set correctly
$actualValue = (Get-ItemProperty -Path $registryPath -Name $valueName).$valueName
if ($actualValue -ge $valueData) {
    Write-Host "SUCCESS: '$valueName' is set to $actualValue KB at '$registryPath'." -ForegroundColor Green
}
else {
    Write-Host "ERROR: Failed to set '$valueName'. Current value: $actualValue KB." -ForegroundColor Red
}
