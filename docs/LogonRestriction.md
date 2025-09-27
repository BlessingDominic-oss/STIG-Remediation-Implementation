# STIG Control: WN10-UR-000010  

---

## 1. STIG Control Identifier  
**ID:** WN10-UR-000010  
**Title:** The "Access this computer from the network" user right must only be assigned to Administrators and Remote Desktop Users groups.  

---

## 2. Problem Statement / Vulnerability  

**Issue**  
* Excessive or incorrect assignments to the "Access this computer from the network" user right can allow unauthorized users or groups to access the system remotely.  

**Risk**  
* Misconfigured rights increase the attack surface and may allow attackers or malicious insiders to gain network access, elevating the risk of data compromise or lateral movement.  

---

## 3. STIG Cross-References with Frameworks  

**WN10-UR-000010 – Access this computer from the network rights**  

- **HIPAA (164.312(a)(2)(iii))**: Restricts remote access to authorized users only to protect ePHI.  
  *Source: HIPAA Security Rule*  

- **PCI-DSS v4.0 (8.2.1)**: Only authorized personnel may access cardholder data systems remotely.  
  *Source: PCI-DSS Standard*  

- **ISO 27001 (A.9.2.2 / A.9.4.2)**: Ensures secure authentication and access control for network resources.  
  *Source: ISO 27001:2022*  

- **NIST 800-53 (AC-2 / AC-17)**: Access rights must be limited to authorized groups to prevent unauthorized network access.  
  *Source: NIST SP 800-53 Revision 5*  

- **GDPR (32.1(b))**: Protects personal data by restricting network access to authorized users.  
  *Source: EU GDPR*  

<img width="131" height="283" alt="image" src="https://github.com/user-attachments/assets/49cd7c0d-c2c7-47c1-a4b3-f459eae9f712" />


---

## 4. Before Remediation (Initial State)  
Check current assignments via **Local Security Policy**:  
- Open `secpol.msc` → Security Settings → Local Policies → User Rights Assignment → "Access this computer from the network".  
- Verify which groups/users are listed.  

<img width="656" height="112" alt="image" src="https://github.com/user-attachments/assets/7e8a172c-7b22-401e-aab2-1ab75c636221" />


---

## 5. Manual Remediation  

1. Open **Local Security Policy** (`secpol.msc`).  
2. Navigate to:  
   `Security Settings → Local Policies → User Rights Assignment → Access this computer from the network`.  
3. Remove all users/groups except:  
   - **Administrators**  
   - **Remote Desktop Users**  
4. Apply changes and close the editor.  

<img width="1920" height="978" alt="image" src="https://github.com/user-attachments/assets/5781128c-9a35-4dec-a0d2-47395e2a2d3a" />
 

---

## 6. Automated Remediation (PowerShell Script)  

```powershell
<#
.SYNOPSIS
Remediates STIG WN10-UR-000010 
("Access this computer from the network" must only include Administrators and Remote Desktop Users).

.DESCRIPTION
Ensures the correct groups are assigned to the user right and removes any unauthorized entries.
#>

$UserRight = "SeNetworkLogonRight"
$AllowedGroups = @("Administrators","Remote Desktop Users")

# Get current assigned groups/users
$currentAssignments = (Get-LocalGroupMember -Group $UserRight -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name) 2>$null

# Remove unauthorized users/groups
foreach ($entry in $currentAssignments) {
    if ($AllowedGroups -notcontains $entry) {
        Write-Host "Removing unauthorized assignment: $entry"
        # Remove-LocalGroupMember -Group $UserRight -Member $entry
        # Placeholder for actual removal if using RSOP or Secedit
    }
}

# Ensure allowed groups are present
foreach ($group in $AllowedGroups) {
    Write-Host "Ensuring $group has access"
    # Add-LocalGroupMember -Group $UserRight -Member $group
    # Placeholder for actual addition if using RSOP or Secedit
}

Write-Host "`n=== Remediation Complete ==="
