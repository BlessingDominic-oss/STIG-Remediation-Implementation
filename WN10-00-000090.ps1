<#
.SYNOPSIS
Remediates STIG ID WN10-00-000090 by disabling Remote Assistance 
(both solicited and offer assistance).

.NOTES
Author  : Blessing Dominic Nze
Date    : 2025-09-18
Version : 1.1
STIG-ID : WN10-00-000090
#>

# --- Registry Paths & Values ---
$regPathSolicited = "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance"
$regPathOffer     = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services"

$values = @(
    @{ Path = $regPathSolicited; Name = "fAllowToGetHelp"; Desired = 0 },
    @{ Path = $regPathOffer;     Name = "fAllowUnsolicited"; Desired = 0 },
    @{ Path = $regPathOffer;     Name = "fAllowUnsolicitedFullControl"; Desired = 0 }
)

# --- Apply Remediation ---
foreach ($item in $values) {
    if (-not (Test-Path $item.Path)) {
        New-Item -Path $item.Path -Force | Out-Null
    }
    Set-ItemProperty -Path $item.Path -Name $item.Name -Value $item.Desired -Type DWord
}

# --- Verification ---
Write-Host "`n--- Verification Results ---"
foreach ($item in $values) {
    $current = (Get-ItemProperty -Path $item.Path -Name $item.Name -ErrorAction SilentlyContinue).$($item.Name)
    if ($current -eq $item.Desired) {
        Write-Host "PASS: $($item.Name) at $($item.Path) is set to $current"
    } else {
        Write-Host "FAIL: $($item.Name) at $($item.Path) is $current (expected $($item.Desired))"
    }
}
