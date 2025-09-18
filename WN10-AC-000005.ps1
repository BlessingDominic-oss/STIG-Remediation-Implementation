<#
.SYNOPSIS
Remediates and verifies Account Lockout Policy settings to comply with Windows 10 STIGs.

.NOTES
Author  : Blessing Dominic Nze
Date    : 2025-09-18
Version : 1.0
STIG-ID : WN10-AC-000005 (Duration), WN10-AC-000010 (Threshold), WN10-AC-000015 (Reset Counter)
#>

# === Remediation ===
Write-Host "Applying Account Lockout Policy Remediation..." -ForegroundColor Cyan

# Export current security policy
secedit /export /cfg C:\acpolicy.cfg > $null

# Replace or configure lockout settings
(Get-Content C:\acpolicy.cfg) `
    -replace "LockoutDuration = \d+", "LockoutDuration = 15" `
    -replace "LockoutBadCount = \d+", "LockoutBadCount = 5" `
    -replace "ResetLockoutCount = \d+", "ResetLockoutCount = 15" |
    Set-Content C:\acpolicy.cfg

# Apply the updated security policy
secedit /configure /db C:\Windows\Security\Local.sdb /cfg C:\acpolicy.cfg /areas SECURITYPOLICY > $null

# Cleanup
Remove-Item C:\acpolicy.cfg -Force

Write-Host "Remediation complete. Verifying settings..." -ForegroundColor Green


# === Verification ===
secedit /export /cfg C:\verify_acpolicy.cfg > $null

$lockoutDuration = (Select-String -Path C:\verify_acpolicy.cfg -Pattern "LockoutDuration").ToString()
$lockoutThreshold = (Select-String -Path C:\verify_acpolicy.cfg -Pattern "LockoutBadCount").ToString()
$resetCounter = (Select-String -Path C:\verify_acpolicy.cfg -Pattern "ResetLockoutCount").ToString()

Remove-Item C:\verify_acpolicy.cfg -Force

Write-Host "Verification Results:" -ForegroundColor Yellow
Write-Host $lockoutDuration
Write-Host $lockoutThreshold
Write-Host $resetCounter

Write-Host "`nExpected values -> LockoutDuration = 15, LockoutBadCount = 5, ResetLockoutCount = 15" -ForegroundColor Cyan
