# STIG Control: WN10-CC-000165

## 1. STIG Control Identifier  
**ID:** WN10-CC-000165  
**Title:** Unauthenticated RPC clients must be restricted from connecting to the RPC server.  

## 2. Problem Statement / Vulnerability  

**Issue**  
* Allowing unauthenticated RPC clients increases the attack surface for remote exploitation and unauthorized access.  

**Risk**  
* Unauthorized RPC connections could allow attackers to perform actions on the server or retrieve sensitive data without authentication.  

## 3. STIG Cross-References with Frameworks  

**WN10-CC-000165 – Unauthenticated RPC clients must be restricted from connecting to the RPC server**  

- **HIPAA (164.312(a)(1))**: Limits unauthorized access to ePHI over network services.  
  *Source: HIPAA Security Rule*  

- **PCI-DSS v4.0 (1.2.3)**: Restricts remote access to prevent untrusted client connections.  
  *Source: PCI-DSS Standard*  

- **ISO 27001 (A.9.1.2)**: Access to network services must be controlled and authenticated.  
  *Source: ISO 27001:2022*  

- **NIST 800-53 (AC-3 / AC-17)**: Enforces authentication for remote access to mitigate network exploitation risks.  
  *Source: NIST SP 800-53 Revision 5*  

- **GDPR (32.1(a))**: Ensures network access controls to protect personal data from unauthorized remote clients.  
  *Source: EU GDPR*  

> <img width="602" height="149" alt="image" src="https://github.com/user-attachments/assets/0266c030-f114-473d-881a-db42e83e2ee4" />  <img width="133" height="187" alt="image" src="https://github.com/user-attachments/assets/06432d7e-688f-4b3f-8b21-4dab2f8bb5bb" />



## 4. Before Remediation (Initial State)
Before remediation:
> <img width="794" height="110" alt="image" src="https://github.com/user-attachments/assets/93a29c26-4040-4d35-8c82-40230e4cf63f" />


## 5. Manual Remediation  

via Group Policy:  
1. Open `gpedit.msc`.  
2. Navigate to:  
   `Computer Configuration → Administrative Templates → System → Remote Procedure Call`.  
3. Enable the policy: **"Restrict Unauthenticated RPC clients"** or similar setting.  
4. Apply changes and restart the system if required.  

> <img width="1584" height="953" alt="image" src="https://github.com/user-attachments/assets/b1025965-c869-4c27-99df-6b7eafad834f" />
 
> [Policy enabled]
> <img width="1065" height="891" alt="image" src="https://github.com/user-attachments/assets/aac0ea3c-8017-4800-8549-c718696ee316" />


## 6. Automated Remediation (PowerShell Script)

```powershell
<#
.SYNOPSIS
Remediates STIG WN10-CC-000165
(Restrict unauthenticated RPC clients from connecting to the RPC server).

.DESCRIPTION
Ensures the relevant registry key or policy is configured to enforce authentication for RPC connections.
#>

$registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Rpc"
$valueName    = "RestrictUnauthenticatedRPCClients"
$expectedValue = 1

Write-Host "=== Remediating STIG WN10-CC-000165 ===`n"

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

> <img width="1233" height="605" alt="image" src="https://github.com/user-attachments/assets/ba18af3d-1697-42dd-886d-7294535b116e" />

## 7. Testing / Verification

1. SCript

``` PowerShell
Write-Host "=== Verifying STIG WN10-CC-000165 ===`n"

if (Test-Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue |
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

><img width="1207" height="599" alt="image" src="https://github.com/user-attachments/assets/c7802af4-1bf7-4dcd-8659-5a22ab39e975" />
 
3. Nessus / STIG Scan Pass

> <img width="791" height="42" alt="image" src="https://github.com/user-attachments/assets/7d418f71-2ea3-454b-9e16-9ba52afd769c" />


## 8. Source(s) of Information

* DISA STIG Viewer

* Microsoft Docs: RPC Security and Authentication Settings
























