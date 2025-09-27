# STIG Control: WN10-CC-000370  

## 1. STIG Control Identifier  
**ID:** WN10-CC-000370  
**Title:** The convenience PIN for Windows 10 must be disabled.  

> **Note:** Manual remediation is recommended for verification on actual devices, while the PowerShell script can be used for automated deployment across multiple systems.

## 2. Problem Statement / Vulnerability  

**Issue**  
* Convenience PIN sign-in provides a less secure authentication method compared to complex passwords. If enabled, it could allow unauthorized access to systems.  

**Risk**  
* Using a PIN as an alternative sign-in method may bypass stronger password requirements, increasing the risk of unauthorized access to sensitive information.  

## 3. STIG Cross-References with Frameworks  

**WN10-CC-000370 – The convenience PIN for Windows 10 must be disabled**  

- **HIPAA (164.312(a)(2)(iii))**: Requires strong authentication methods to protect ePHI.  
  *Source: HIPAA Security Rule*  

- **PCI-DSS v4.0 (8.2.2)**: Strong authentication prevents unauthorized access to cardholder data.  
  *Source: PCI-DSS Standard*  

- **ISO 27001 (A.9.4.2)**: Enforces secure authentication methods for accessing systems.  
  *Source: ISO 27001:2022*  

- **NIST 800-53 (IA-5(1))**: Requires multifactor authentication and discourages weak alternative methods.  
  *Source: NIST SP 800-53 Revision 5*  

- **GDPR (32.1(b))**: Ensures technical measures are in place to secure personal data from unauthorized access.  
  *Source: EU GDPR*

> <img width="607" height="170" alt="image" src="https://github.com/user-attachments/assets/812d1e01-4bc3-43a9-9be3-7a7465b71838" /> <img width="129" height="215" alt="image" src="https://github.com/user-attachments/assets/9324f544-e221-43fd-a271-2292929d9041" />


## 4. Before Remediation (Initial State)
Before remediation, check if the convenience PIN is enabled.  

> <img width="482" height="124" alt="image" src="https://github.com/user-attachments/assets/0850055e-cfce-4acb-80fb-8402275be1a9" />

## 5. Manual Remediation  

via Group Policy:  
- Open `gpedit.msc`.  
- Navigate to:  
  `Computer Configuration → Administrative Templates → System → Logon`  
- Configure **"Turn on convenience PIN sign-in"** to **Disabled**.
  
  <img width="1807" height="880" alt="image" src="https://github.com/user-attachments/assets/4ae0ab26-5d54-4693-81d3-63b1e86e9148" />
  
> <img width="1003" height="897" alt="image" src="https://github.com/user-attachments/assets/30736b1d-af63-4ae0-9b72-c15df42f3ac1" /> <img width="1016" height="849" alt="image" src="https://github.com/user-attachments/assets/e61184a3-044c-49bb-b6ca-3694fce696ef" />
  

## 6. Automated Remediation (PowerShell Script)
Disable convenience PIN for Windows 10:
```powershell
<#
.SYNOPSIS
Remediates STIG WN10-CC-000370 
(The convenience PIN for Windows 10 must be disabled).

.DESCRIPTION
Disables the registry setting that allows convenience PIN sign-in.
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork"
$valueName    = "Enabled"
$expectedValue = 0

Write-Host "=== Remediating STIG WN10-CC-000370 ===`n"

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
Getting the convenience PIN for Windows 10 must be disabled with PowerShell
<img width="1243" height="701" alt="image" src="https://github.com/user-attachments/assets/fb967c08-9f45-4e82-8619-563ea5cbb2a4" />

## 7. Testing / Verification  

1. **PowerShell Verification Script**  
``` hpowershell
Write-Host "=== Verifying STIG WN10-CC-000370 ===`n"

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
1. Verified Output
The convenience PIN for Windows 10 is Disabled with PowerShell
<img width="1301" height="524" alt="image" src="https://github.com/user-attachments/assets/67b8782f-fb46-4683-9dc4-25d1d87502ff" />

2. Nessus / STIG Scan Pass
<img width="551" height="115" alt="image" src="https://github.com/user-attachments/assets/e85cede2-6aa1-40e2-8589-eba1017ed98d" />

## 8. References

* Microsoft Documentation – Windows Hello for Business
* DISA STIG Documentation





