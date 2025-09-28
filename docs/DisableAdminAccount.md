# STIG Control: WN10-SO-000005  

## 1. STIG Control Identifier  
**ID:** WN10-SO-000005  
**Title:** The built-in administrator account must be disabled.  

## 2. Problem Statement / Vulnerability  

**Issue**  
* The default Administrator account is a high-value target for attackers. If enabled, it could be exploited for privilege escalation or lateral movement.  

**Risk**  
* An active built-in Administrator account increases the attack surface and provides adversaries a predictable target for brute-force or credential attacks.  

## 3. STIG Cross-References with Frameworks  

- **HIPAA (164.308(a)(3))**: Requires implementation of workforce security policies to prevent unauthorized access.  
- **PCI-DSS v4.0 (7.2.1)**: Restrict user access to system components and cardholder data by business need to know.  
- **ISO 27001 (A.9.2.3)**: Management of privileged access rights must be strictly controlled.  
- **NIST 800-53 (AC-2, AC-6)**: Ensure that accounts are managed securely and enforce least privilege principles.  
- **GDPR (32.1(b))**: Mandates technical measures to ensure personal data is protected from unauthorized access.  

> <img width="131" height="251" alt="image" src="https://github.com/user-attachments/assets/9f9067e4-8ebf-4dd4-bc99-47d9f6fdf391" /> <img width="503" height="182" alt="image" src="https://github.com/user-attachments/assets/5a693f3f-9f23-474e-aca4-30ed93d6c6f5" />



## 4. Before Remediation (Initial State)  
* The built-in Administrator account is enabled by default on Windows installations.  
* This can be verified via **Local Users and Groups** (`lusrmgr.msc`) or PowerShell.  

> <img width="791" height="74" alt="image" src="https://github.com/user-attachments/assets/3d464a11-a3c6-4a62-a66e-3ff714d82e32" />

## 5. Manual Remediation  

1. Open **Computer Management** (`compmgmt.msc`).  
2. Go to:  
   `System Tools → Local Users and Groups → Users`.  
3. Right-click the **Administrator** account → **Properties**.  
4. Check **Account is disabled** and click **OK**.  

> <img width="1081" height="518" alt="image" src="https://github.com/user-attachments/assets/c73b47b2-969d-4f98-acaf-afd1ef6888b4" />

> <img width="980" height="862" alt="image" src="https://github.com/user-attachments/assets/496036e3-b775-4fe6-8d6a-32d47a79b6bb" />


## 6. Automated Remediation (PowerShell Script)  

```powershell
<#
.SYNOPSIS
Remediates STIG WN10-SO-000005
(The built-in Administrator account must be disabled).

.DESCRIPTION
Disables the built-in Administrator account if enabled.
#>

Write-Host "=== Remediating STIG WN10-SO-000005 ===`n"

# Disable built-in Administrator account
Disable-LocalUser -Name "Administrator" -ErrorAction SilentlyContinue

Write-Host "[FIXED] Built-in Administrator account has been disabled."
Write-Host "`n=== Remediation Complete ==="

```

<img width="1046" height="802" alt="image" src="https://github.com/user-attachments/assets/21b3ede7-ba53-40ac-bb33-713ce0d02d81" />

## 7. Testing / Verification
1. Sript

```powershell

Write-Host "=== Verifying STIG WN10-SO-000005 ===`n"

try {
    $adminAccount = Get-LocalUser | Where-Object { $_.SID -like "S-1-5-*-500" }

    if ($null -eq $adminAccount) {
        Write-Host "PASS: Built-in Administrator account does not exist (renamed or removed)."
    }
    elseif ($adminAccount.Enabled -eq $false) {
        Write-Host "PASS: Built-in Administrator account is disabled."
    }
    else {
        Write-Host "FAIL: Built-in Administrator account ($($adminAccount.Name)) is still enabled."
    }
}
catch {
    Write-Host "FAIL: Unable to query the built-in Administrator account."
}

Write-Host "`n=== Verification Complete ==="

```

2. Verified

<img width="1150" height="530" alt="image" src="https://github.com/user-attachments/assets/c940d5a8-96ac-42f4-9ab5-e4b930414b33" />

3. Nessus / STIG Scan Pass

   <img width="1585" height="85" alt="image" src="https://github.com/user-attachments/assets/56b3bf94-dd63-4ca6-bea1-40ed37712634" />

## 8.  Source(s) of Information
* DISA STIG Viewer
* Microsoft Docs: Disable the local administrator account
* NIST SP 800-53 Rev 5 – AC-2 / AC-6

