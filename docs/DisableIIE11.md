# STIG Control: WN10-CC-000391  

## 1. STIG Control Identifier  
**ID:** WN10-CC-000391  
**Title:** Internet Explorer must be disabled for Windows 10  

## 2. Problem Statement / Vulnerability  

**Issue**  
* Internet Explorer (IE) is outdated and contains multiple security vulnerabilities. Enabling it exposes systems to attacks such as drive-by downloads, phishing, and legacy exploits.  

**Risk**  
* Allowing IE to remain enabled increases the attack surface and may lead to unauthorized access or compromise of sensitive information.  

---

## 3. STIG Cross-References with Frameworks  

**WN10-CC-000391 – Internet Explorer must be disabled**  

- **HIPAA (164.308(a)(1))**: Requires security management controls to reduce vulnerabilities.  
  *Source: HIPAA Security Rule*  

- **PCI-DSS v4.0 (6.2)**: Secure configuration to protect systems and data.  
  *Source: PCI-DSS Standard*  

- **ISO 27001 (A.12.5)**: Ensures secure configuration management of IT assets.  
  *Source: ISO 27001:2022*  

- **NIST 800-53 (CM-7 / SI-2)**: Enforces secure configuration baselines and system protection.  
  *Source: NIST SP 800-53 Revision 5*  

- **GDPR (32.1(b))**: Ensures technical measures are in place to secure personal data.  
  *Source: EU GDPR*

> <img width="127" height="185" alt="image" src="https://github.com/user-attachments/assets/c069b608-7ac2-410d-9192-20e86a269a2e" />  

---

## 4. Before Remediation (Initial State)

The system may have Internet Explorer enabled by default.  

> <img width="792" height="79" alt="image" src="https://github.com/user-attachments/assets/ff1e04e6-88f8-4c54-9d12-b227604f8d8d" />



---

## 5. Manual Remediation  

1. Open **Group Policy Editor** (`gpedit.msc`).  
2. Navigate to:  
   `Computer Configuration → Administrative Templates → Windows Components → Internet Explorer`  
3. Set **"Disable Internet Explorer 11"** to **Enabled**.  
4. Apply the policy and restart the system.

> <img width="727" height="443" alt="image" src="https://github.com/user-attachments/assets/2e53f27e-b429-4c52-9339-2c18ba338ad6" />

We have set **"Disable Internet Explorer 11"** to **Enabled**

<img width="509" height="433" alt="image" src="https://github.com/user-attachments/assets/0c9e4c92-a638-40c4-90d1-101d97c950bf" />


---

## 6. Automated Remediation (PowerShell Script)  

```powershell
<#
.SYNOPSIS
Remediates STIG WN10-CC-000391
(Disables Internet Explorer 11 on Windows 10).

.DESCRIPTION
Sets registry key to disable Internet Explorer.
#>

$registryPath = "HKLM:\Software\Policies\Microsoft\Internet Explorer\Main"
$valueName    = "DisableIE11"
$expectedValue = 1

Write-Host "=== Remediating STIG WN10-CC-000391 ===`n"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Created registry path: $registryPath"
}

Set-ItemProperty -Path $registryPath -Name $valueName -Value $expectedValue -Type DWord
Write-Host "[FIXED] $valueName set to $expectedValue in $registryPath"

Write-Host "`n=== Remediation Complete ==="

```
<img width="1227" height="792" alt="image" src="https://github.com/user-attachments/assets/24c76a32-6ddc-44ca-a02c-7c7d32255aae" />

## 7. Testing / Verification

1. Script

``` PowerShell
Write-Host "=== Verifying STIG WN10-CC-000391 ===`n"

$registryPath = "HKLM:\Software\Policies\Microsoft\Internet Explorer\Main"
$valueName    = "DisableIE11"
$expectedValue = 1

if (Test-Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | `
                    Select-Object -ExpandProperty $valueName
    if ($currentValue -eq $expectedValue) {
        Write-Host "PASS: Internet Explorer is disabled."
    } else {
        Write-Host "FAIL: Internet Explorer is NOT disabled (current value: $currentValue)."
    }
} else {
    Write-Host "FAIL: Registry path $registryPath does not exist."
}

Write-Host "`n=== Verification Complete ==="

```

2. Verified
   
<img width="1247" height="376" alt="image" src="https://github.com/user-attachments/assets/0146900e-5361-4bc1-bec7-6d4f084d79a3" />

3. Nessus / STIG Scan Pass

<img width="791" height="80" alt="image" src="https://github.com/user-attachments/assets/fc3f380a-0425-4a05-8b98-c00fffd02b5f" />


## 8.Source(s) of Information

* DISA STIG Viewer
* Microsoft Docs: Require a password when a computer wakes (Windows 10/11)

