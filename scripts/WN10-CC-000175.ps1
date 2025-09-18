<#
.SYNOPSIS
    Disables Windows compatibility telemetry inventory collection by setting the 'DisableInventory' registry value as required by STIG compliance.
   

.NOTES
    Author          : Blessing Dominic Nze
    LinkedIn        : linkedin.com/in/blessingdominicnze/
    GitHub          : github.com/BlessingDominic-oss
    Date Created    : 2025-04-22
    Last Modified   : 2025-04-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000175.ps1 
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"

# Check if the path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the DisableInventory value to 1 (REG_DWORD)
Set-ItemProperty -Path $regPath -Name "DisableInventory" -Value 1 -Type DWord

# Output the result to verify
Get-ItemProperty -Path $regPath | Select-Object DisableInventory
