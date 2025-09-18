<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Blessing Dominic Nze
    LinkedIn        : linkedin.com/in/BlessingDominicNze/
    GitHub          : https://github.com/BlessingDominic-oss
    Date Created    : 2025-09-16
    Last Modified   : 2025-09-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

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

# Define the registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$MinValue = 32768

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Check if the value exists
if (-not (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue)) {
    # Create the value if missing, set to 32768
    New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $MinValue -Force | Out-Null
    Write-Output "Created MaxSize and set to $MinValue"
}
else {
    # Get current value
    $CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName).$ValueName

    if ($CurrentValue -lt $MinValue) {
        # Update if smaller than required
        Set-ItemProperty -Path $RegPath -Name $ValueName -Value $MinValue
        Write-Output "Updated MaxSize from $CurrentValue to $MinValue"
    }
    else {
        Write-Output "MaxSize already set to $CurrentValue (compliant)"
    }
}

