# STIG Control: WN10-CC-000145

## 1. STIG Control Identifier  
**ID:** WN10-CC-000145 
**Title:** Windows 10 must be configured to lock the screen after 15 minutes of inactivity.  

## 2. Problem Statement / Vulnerability 

Issue
* Inactive sessions can expose systems to unauthorized use. Configuring automatic lock reduces the attack window. 

Risk
* Leaving sessions open allows attackers to access sensitive data. Locking after inactivity enforces secure use. 

## 3. Before Remediation (Initial State)
Before remediation:
> <a href="https://ibb.co/ymNqb019"><img src="https://i.ibb.co/8nm9SMpC/image.png" alt="image" border="0"></a>

The registry key doesn’t exist at all on our VM.
> <a href="https://ibb.co/tP27FBn1"><img src="https://i.ibb.co/vvd7R1fM/image.png" alt="image" border="0"></a>
  

## 4. Manual Remediation  
1. Open **Group Policy Editor** (`gpedit.msc`).  
2. Navigate to:  
   `Computer Configuration → Windows Settings → Security Settings → Local Policies → Security Options`.  
3. Verify **Interactive logon: Machine inactivity limit** is set to **900 seconds (15 minutes)** or less.  

 [ Group Policy setting Machine Inactivity Limit]
> <img width="1794" height="942" alt="image" src="https://github.com/user-attachments/assets/0483f252-e533-4bba-9ead-58055de751cc" />


## 5. Automated Remediation (PowerShell Script)
Set the **Machine inactivity limit** to 900 seconds (15 minutes).  
```powershell
<#
.SYNOPSIS
Remediates STIG WN10-CC-000145 
(Users must be prompted for a password on resume from sleep on battery).

.DESCRIPTION
Ensures the registry value DCSettingIndex is set to 1 for the 
GUID controlling "Require a password when a computer wakes (on battery)".
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$valueName    = "DCSettingIndex"
$expectedValue = 1

Write-Host "=== Remediating STIG WN10-CC-000145 ===`n"

# Create path if missing
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Created registry path: $registryPath"
}

# Apply setting
Set-ItemProperty -Path $registryPath -Name $valueName -Value $expectedValue -Type DWord
Write-Host "[FIXED] $valueName set to $expectedValue in $registryPath"

Write-Host "`n=== Remediation Complete ==="

```
**Placeholder image: [screenshot of policy configured at 900 seconds]**

<img width="1229" height="691" alt="image" src="https://github.com/user-attachments/assets/608cbf94-13b8-4431-b6cc-cd7b426a89f5" />


## 6. Testing / Verification
1. Script
```powershell
Write-Host "=== Verifying STIG WN10-CC-000145 ===`n"

if (Test-Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | `
                    Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

    if ($null -eq $currentValue) {
        Write-Host "FAIL: $valueName does not exist under $registryPath."
    }
    elseif ($currentValue -eq $expectedValue) {
        Write-Host "PASS: $valueName is set correctly to $expectedValue."
    }
    else {
        Write-Host "FAIL: $valueName is set to $currentValue (expected $expectedValue)."
    }
} else {
    Write-Host "FAIL: Registry path $registryPath does not exist."
}

Write-Host "`n=== Verification Complete ==="
```
2. Verified
   
<img width="1270" height="246" alt="image" src="https://github.com/user-attachments/assets/abd232b2-aaa5-455a-af8d-961830ce13a2" />

4. Nessus / STIG Scan Pass


## 7. References  
- **DISA STIG:** Windows 10 STIG V2R5 – WN10-CC-000145  
- **NIST SP 800-53 Rev 5:** AC-11 – Session Lock  

## 8. Cross References / Mapping  
- **NIST Rev 5:** AC-11  
- **CIS Benchmark:** Power Options – Require a password on wakeup  
- **Comment:** Both NIST and CIS enforce similar session lock and wakeup authentication requirements.  

## 9. Comments  
Requiring a password on resume from sleep ensures that unattended systems are protected from unauthorized access.  

## 10. Source(s) of Information  
- DISA STIG Viewer  
- Microsoft Docs: [Require a password when a computer wakes (Windows 10/11)](https://learn.microsoft.com/en-us/troubleshoot/windows-client/windows-security/require-password-wakeup)  

