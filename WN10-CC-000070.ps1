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
    STIG-ID         : WN10-CC-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000070).ps1 
#>

<#
.SYNOPSIS
Ensures Virtualization-Based Security (VBS) is enabled with Secure Boot / DMA protections as required 
by STIG ID WN10-CC-000070.
#>

# Registry path for Device Guard policies
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"

# Create path if missing
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Set required values
Set-ItemProperty -Path $registryPath -Name "EnableVirtualizationBasedSecurity" -Value 1 -Type DWord
Set-ItemProperty -Path $registryPath -Name "RequirePlatformSecurityFeatures" -Value 3 -Type DWord   # 1 = Secure Boot, 3 = Secure Boot + DMA




# Verify values
$settings = Get-ItemProperty -Path $registryPath
Write-Host "EnableVirtualizationBasedSecurity = $($settings.EnableVirtualizationBasedSecurity)"
Write-Host "RequirePlatformSecurityFeatures  = $($settings.RequirePlatformSecurityFeatures)"
