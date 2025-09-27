# STIG Control: WN10-CC-000145  

## 1. STIG Control Identifier  
**ID:** WN10-CC-000145  
**Title:** Users must be prompted for a password on resume from sleep (on battery).  

## 2. Problem Statement / Vulnerability  

**Issue**  
* If the system does not require a password when resuming from sleep, unauthorized users could gain access to data.  

**Risk**  
* Leaving a computer unattended while on battery without re-authentication exposes sensitive data and increases the risk of compromise.  


## 3. STIG Cross-References with Frameworks  

**WN10-CC-000145 – Users must be prompted for a password on resume from sleep (on battery)**  

- **HIPAA (164.312(a)(2)(iii))**: Requires automatic logoff or session lock to protect ePHI.  
  *Source: HIPAA Security Rule*  

- **PCI-DSS v4.0 (8.2.8)**: Sessions must be re-authenticated upon reactivation to protect cardholder data.  
  *Source: PCI-DSS Standard*  

- **ISO 27001 (A.9.2.6)**: Secure log-on procedures must be enforced when returning from idle or sleep states.  
  *Source: ISO 27001:2022*  

- **NIST 800-53 (AC-11 / AC-11(1))**: Session lock must be enforced after inactivity and require re-authentication to resume.  
  *Source: NIST SP 800-53 Revision 5*  

- **GDPR (32.1(b))**: Ensures appropriate technical measures are in place to secure personal data against unauthorized access.  
  *Source: EU GDPR*
  
> <img width="137" height="203" alt="image" src="https://github.com/user-attachments/assets/9e80911f-8fca-43d4-859c-5c84255a9bb1" /> <img width="604" height="149" alt="image" src="https://github.com/user-attachments/assets/35cd25bd-1360-45c1-947f-858a566c419c" />


## 4. Before Remediation (Initial State)
Before remediation:
> <a href="https://ibb.co/ymNqb019"><img src="https://i.ibb.co/8nm9SMpC/image.png" alt="image" border="0"></a>

The registry key doesn’t exist at all on our VM.
> <a href="https://ibb.co/tP27FBn1"><img src="https://i.ibb.co/vvd7R1fM/image.png" alt="image" border="0"></a>
  

## 5. Manual Remediation  

via Group Policy:  
- Open `gpedit.msc`.  
- Navigate to:  
  `Computer Configuration → Administrative Templates → System → Power Management → Sleep Settings`  
- Configure **"Require a password when a computer wakes (on battery)"** to **Enabled**.

  <img width="1471" height="841" alt="image" src="https://github.com/user-attachments/assets/ca81d9f3-4d18-4dd5-bdb1-3950945a5d2e" />
Here's not enabled:                                                                                                                     
  > <img width="1001" height="889" alt="image" src="https://github.com/user-attachments/assets/240fa6ed-188b-4b86-8697-e14e99f335db" /> 

Now enabled:
> <img width="1022" height="951" alt="image" src="https://github.com/user-attachments/assets/ce75103f-b773-4376-ae1d-f50e4d42db94" />




## 6. Automated Remediation (PowerShell Script)
Require a password when a computer wakes (on battery)" to Enabled
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


## 7. Testing / Verification
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

3. Nessus / STIG Scan Pass
<img width="793" height="43" alt="image" src="https://github.com/user-attachments/assets/6ce734ac-a3a5-4d8a-a485-e1b10321d74e" />


## 8. Source(s) of Information  
- DISA STIG Viewer  
- Microsoft Docs: [Require a password when a computer wakes (Windows 10/11)](https://learn.microsoft.com/en-us/troubleshoot/windows-client/windows-security/require-password-wakeup)  

