# STIG Control: WN10-CC-000020

## 1. STIG Control Identifier  
**ID:** WN10-CC-000020  
**Title:** Windows 10 must be configured to lock the screen after 15 minutes of inactivity.  

## 2. Description & Rationale 
Inactive sessions can expose systems to unauthorized use. Configuring automatic lock reduces the attack window. Leaving sessions open allows attackers to access sensitive data. Locking after inactivity enforces secure use. 

## 3. Before Remediation
> <a href="https://ibb.co/ymNqb019"><img src="https://i.ibb.co/8nm9SMpC/image.png" alt="image" border="0"></a>
  

## 4. Check Text  
1. Open **Group Policy Editor** (`gpedit.msc`).  
2. Navigate to:  
   `Computer Configuration → Windows Settings → Security Settings → Local Policies → Security Options`.  
3. Verify **Interactive logon: Machine inactivity limit** is set to **900 seconds (15 minutes)** or less.  

**Placeholder image: [screenshot of Group Policy setting Machine Inactivity Limit]**

## 5. Fix Text  
Set the **Machine inactivity limit** to 900 seconds (15 minutes).  

**Placeholder image: [screenshot of policy configured at 900 seconds]**

## 6. References  
- **DISA STIG:** Windows 10 STIG V2R5 – WN10-CC-000020  
- **NIST SP 800-53 Rev 5:** AC-11 – Session Lock  

## 7. Cross References / Mapping  
- **NIST Rev 5:** AC-11  
- **CIS Benchmark:** Screensaver inactivity recommendations  
- **Comment:** Both NIST and CIS enforce similar inactivity lock requirements.  

## 8. Comments  
Session timeouts are a common security baseline across frameworks.  

## 9. Source(s) of Information  
- DISA STIG Viewer  
- Microsoft Docs: [Interactive logon Machine inactivity limit](https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit)  
