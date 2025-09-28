# STIG Control: WN10-AU-000082  

## 1. STIG Control Identifier  
**ID:** WN10-AU-000082  
**Title:** Windows 10 must be configured to audit Object Access - File Share successes.  

## 2. Problem Statement / Vulnerability  

**Issue**  
* Without auditing enabled for File Share successes, access to shared resources cannot be tracked, limiting the ability to investigate unauthorized data access or breaches.  

**Risk**  
* Failure to log successful access attempts makes it harder to detect malicious insiders or compromised accounts, weakening accountability and forensics capability.  

## 3. STIG Cross-References with Frameworks  

**WN10-AU-000082 – Audit Object Access: File Share (Success)**  

- **HIPAA (164.312(b))**: Requires audit controls to record and examine activity in systems that contain or use ePHI.  
  *Source: HIPAA Security Rule*  

- **PCI-DSS v4.0 (10.2.1.2)**: Requires logging of all access to system components and data, including successful access events.  
  *Source: PCI-DSS Standard*  

- **ISO 27001 (A.12.4.1)**: Event logs must record user activities and security events, including access to shared resources.  
  *Source: ISO 27001:2022*  

- **NIST 800-53 (AU-2, AU-12)**: Audit records must capture events that support investigations, including access to shared files.  
  *Source: NIST SP 800-53 Revision 5*  

- **GDPR (Art. 30, 32)**: Organizations must ensure accountability and the ability to detect unauthorized data access.  
  *Source: EU GDPR*  

> <img width="134" height="270" alt="image" src="https://github.com/user-attachments/assets/df02f1d7-cc73-4998-ab0d-860fa41aff32" /> <img width="610" height="166" alt="image" src="https://github.com/user-attachments/assets/414d4b31-76ef-45d1-b132-85f433b8d99c" />

  

---

## 4. Before Remediation (Initial State)  
Before remediation:  
- The policy **Audit File Share (Success)** is either **Not Configured** or **Disabled**.  

> <img width="1630" height="270" alt="image" src="https://github.com/user-attachments/assets/1d672ffe-bef8-415d-a039-9f382de01f2b" />

---

## 5. Manual Remediation  

via Group Policy:  
1. Open `gpedit.msc`.  
2. Navigate to:  
   `Computer Configuration → Windows Settings → Security Settings → Advanced Audit Policy Configuration → System Audit Policies → Object Access → Audit File Share`.  
3. Set **"Audit File Share (Success)"** to **Enabled**.  

> <img width="969" height="991" alt="image" src="https://github.com/user-attachments/assets/1cbdc42a-cef9-4b8e-8138-944960f9f7b1" /> <img width="918" height="941" alt="image" src="https://github.com/user-attachments/assets/1da7401a-f693-44d5-9133-5ac3188f0ba7" />

 

---

## 6. Automated Remediation (PowerShell Script)  

```powershell
<#
.SYNOPSIS
Remediates STIG WN10-AU-000082
(Enable auditing of File Share successes).
#>

Write-Host "=== Remediating STIG WN10-AU-000082 ===`n"

# Enable File Share Success auditing
auditpol /set /subcategory:"File Share" /success:enable

Write-Host "[FIXED] Audit File Share (Success) has been enabled."
Write-Host "`n=== Remediation Complete ==="
```
Enabling the auditing of File Sharing Successes (Successful)

<img width="627" height="397" alt="image" src="https://github.com/user-attachments/assets/c32feefd-e859-45c5-9405-750810b55a3e" />

## Testing / Verification

1. Verification Script

<#
.SYNOPSIS
Verifies STIG WN10-AU-000082
(Checks if auditing of File Share successes is enabled).
#>

```
Write-Host "=== Verifying STIG WN10-AU-000082 ===`n"

$auditStatus = auditpol /get /subcategory:"File Share"

if ($auditStatus -match "Success") {
    Write-Host "PASS: File Share Success auditing is enabled."
} else {
    Write-Host "FAIL: File Share Success auditing is NOT enabled."
}

Write-Host "`n=== Verification Complete ==="
```

2. Verified
<img width="439" height="416" alt="image" src="https://github.com/user-attachments/assets/96ba17ff-a276-457e-8a42-394014ff5123" />

3. Nessus / STIG Scan Pass

<img width="791" height="41" alt="image" src="https://github.com/user-attachments/assets/18a0cce3-e9bb-4754-9e1d-83fdc6a67aae" />

## 8.Source(s) of Information

* DISA STIG Viewer
* Microsoft Docs: Advanced security audit policy settings
* Microsoft Docs: Audit File Share



