<#
.SYNOPSIS
Remediates STIG WN10-CC-000030 by disabling ICMP Redirects.

.NOTES
Author  : Blessing Dominic Nze
Date    : 2025-09-18
Version : 1.0
STIG-ID : WN10-CC-000030
#>

# Define registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
$valueName = "EnableICMPRedirect"
$desiredValue = 0

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord

# Verify remediation
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName | Select-Object -ExpandProperty $valueName
if ($currentValue -eq $desiredValue) {
    Write-Host "PASS: ICMP Redirects disabled (`$EnableICMPRedirect = $currentValue`)." -ForegroundColor Green
} else {
    Write-Host "FAIL: ICMP Redirects not correctly configured (`$EnableICMPRedirect = $currentValue`)." -ForegroundColor Red
}
