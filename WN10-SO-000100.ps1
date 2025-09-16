<#
.SYNOPSIS
This PowerShell script ensures that SMB security signing is required by setting 
'RequireSecuritySignature' to 1 under the LanmanWorkstation parameters.


.NOTES
    Author          : Blessing Dominic Nze
    LinkedIn        : linkedin.com/in/BlessingDominicNze/
    GitHub          : https://github.com/BlessingDominic-oss
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000100 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>


# Define registry location and required value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$valueName    = "RequireSecuritySignature"
$valueData    = 1   # Must be set to 1 (enabled)

# Create registry path if missing
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Apply the RequireSecuritySignature setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Verify that the value was set correctly
$actualValue = (Get-ItemProperty -Path $registryPath -Name $valueName).$valueName
if ($actualValue -eq $valueData) {
    Write-Host "SUCCESS: '$valueName' is set to $actualValue at '$registryPath'." -ForegroundColor Green
}
else {
    Write-Host "ERROR: Failed to set '$valueName'. Current value: $actualValue." -ForegroundColor Red
}


