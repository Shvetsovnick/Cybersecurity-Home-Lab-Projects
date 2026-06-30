# ⚠️ This repository contains real malware samples. See /artifacts/README.md before proceeding.


## Executive Summary: 

This investigation analyzes a phishing email impersonating a Microsoft 365 file-sharing notification. The email contains a PDF attachment that redirected the user to a deceptive domain impersonating Adobe/Microsoft download infrastructure and attempted to deliver a Windows executable payload.  

 

## Email artifacts: 

Sending email address: Allergy Research Canada Admin <admin@allergyresearch.ca> 

Subject Line: [EXTERNAL]  Fw: allergy research-178418 

Reply-to Address: Carmel Llarena-Binay <cbinay@allergyresearch.ca> 

Recipient: Allergy Research Canada Admin <admin@allergyresearch.ca> 

Real Recipients: alawran1@its.jnj.com, arami120@its.jnj.com, dkellou@its.jnj.com, 

gcoca-invoice@its.jnj.com 

Date and Time: Fri, 26 Jun 2026 19:55:30 +0000 

Sending Server IP: 52.101.191.99 

Reverse DNS: Microsoft Corporation 

 

## Attached File Artifacts: 

Attachment name: 10480431_Allergy.pdf 

Attachment sha256 hash: 9098F9211DBA060E6185E3E705ACE65A9AF3E13FCB5D3B72E7F33B0014595CD2 

URL: hxxps[:]//pacifiveiw[.]net/reader 

URL redirect: hxxps[:]//get[.]adobe[.]com[.]pacifiveiw[.]net/reader-download-trackingid-R9YU1LF8K-accepted/adobe/ 

  

## Payload artifacts:  

Name: En-reader-lavwallWin.exe 

SHA256 hash: 0261DE3A5A6A58101E7FEA5FDECDD59FE68508E46F0DF5F5BCA69D79A69FA51A 

  

  

  

## Email header analysis: 

Delivery chain looks as follows:  

[Sender] -> Microsoft 365 Canada YQ1P288MB0949.CANP288 52.101.191.99 Fri, 26 Jun 2026 19:55:30 +0000 -> 

esa6.jnj-uno.iphmx.com (Cisco IronPort J&J) 216.71.144.144 26 Jun 2026 15:55:34 -0400 -> 

esa15.jnj.iphmx.com (Cisco IronPort J&J) 68.232.141.250 26 Jun 2026 15:55:36 -0400 -> 

CH2PEPF00000143 Fri, 26 Jun 2026 19:55:39 +0000 ->  

CH0P221CA0025 Fri, 26 Jun 2026 19:55:40  +0000 -> 

MN2PR07MB7120 Fri, 26 Jun 2026 19:55:40 +0000 -> 

CH4PR07MB11019 Fri, 26 Jun 2026 19:56:18 +0000 -> Inbox 

 

The message appears to have originated from Microsoft 365 infrastructure authorized for the sender domain. SPF passed. Earlier ARC results indicate DKIM/DMARC passed at a Microsoft hop, but downstream authentication results show DKIM as none and ARC as failed. Therefore, SPF/DMARC alignment does not prove the message is benign; it is more consistent with a legitimate sender account being abused/compromised rather than simple spoofing.  

  

The visible [To]  header shows the sender address itself, while the envelope/internal recipient header [X-CES2-RSMTP] lists multiple J&J recipients. This is consistent with BCC-style or bulk delivery behavior and is commonly seen in phishing campaigns, but the header alone does not provide malicious intent.   

  

  

## Artifact Analysis: 

The email contains a Microsoft 365-themed PDF attachment. The button located in the bottom part of the document leads user to hxxps[:]//pacifiveiw[.]net/reader which is somewhat typosquatting, made to represent "Pacific View".  

VirusTotal search for the domain shows that it has been flagged for malicious activity.  

URL2PNG shows that page cannot be found. 

  

After visiting the domain user being redirected to another page (hxxps[:]//get[.]adobe[.]com[.]pacifiveiw[.]net/reader-download-trackingid-R9YU1LF8K-accepted/adobe/).  

The redirected URL abuses a deceptive subdomain structure [get.adobe.com.pacifiveiw[.]net, not Adobe. 

where message tells him that to open the attachment, he must update the Adobe reader and file "En-reader-lavwallWin.exe" starting to download automatically. The file was sent to the forensic team for further investigation.  

   

## Suggested Defensive Measures: 

Message appears to be sent through Microsoft 365 infrastructure associated with the sender domain. Blocking the sender may lead to future disruption for business. At this point is highly suggested to inform vendor about possible account compromise, requiring taking necessary measures to prevent similar situations in the future.  

Research on the domain that the attachment leads to shows malicious intent and no business justification for any employees needing to access this site. As it has a malicious reputation on VirusTotal, the entire domain can be blocked on the web proxy, preventing employees from connecting to the site.  

  

Requesting a web proxy block for the domains: 

hxxps[:]//pacifiveiw[.]net/ 

hxxps[:]//get[.]adobe[.]com[.]pacifiveiw[.]net 

 

## Scope/Limitation:  

The executable payload was not detonated as part of this report. Further malware analysis would be required to determine persistence, C2 behavior, process activity, and host-based indicators. 

SIEM/EDR review was outside the scope of this exercise, as this investigation was conducted in a simulated environment.   

 

## Conclusion 

This email is assessed as malicious with high confidence. The message used a minimal social engineering lure, a PDF attachment, a deceptive Adobe/Microsoft-style redirect chain, and an executable payload download. The authentication results and delivery path suggest possible abuse or compromise of a legitimate sender mailbox rather than a simple spoofing.  

The strongest malicious indicators are the PDF-embedded URL, the deceptive [get[.]adobe[.]com[.]pacifiveiw[.]net] subdomain structure, the fake Adobe Reader update prompt, and the attempted delivery of a Windows executable. 
