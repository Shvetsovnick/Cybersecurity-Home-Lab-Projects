## Exploring Password Cracking Techniques Using John the Ripper

### Scenario
---
A set of password hashes was obtained from different user accounts. 
The goal is to get familiar with John the Ripper and crack the hashes 
to recover the actual passwords.

#### What we know about the users: 🕵️
- Some users have simple, weak passwords 🤦
- Some use dinosaur names as a base word 🦕
- Many add 4 digits to the end of their password 🔢
- Some apply leet speak substitutions (e.g. a→@ e→3 s→$)
---

### Implementation
---
First I want to run given hashes against standard wordlist (rockyou.txt).
To use John the Ripper I will need to define the hash type.
But hashes are written in format {username:hash}, so I need to separate hash from username. 

```
┌──(kali㉿kali)-[~/Git/Password-Cracking/Files]
└─$ cut -d: -f2 hashes > sepatatedHashes
```
I extracted the hash values to simplyfy further identification and testing. 

Hash identification tools like ```hashid``` provide multiple possible matches. Need to verify that if all provided hashes are in the same format:
```
┌──(kali㉿kali)-[~/Git/Password-Cracking/Files]
└─$ hashid -j separatedHashes |grep -B 2 -E "MD5" 
Analyzing '66014792c8b3bdd74684696f5c46a75c'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing 'de045789eae61633ec4dc711e2b0abf1'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '7640b83ef9f91684b7a49a47647b2ba7'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '8a2432cdd3982a50ebf37e5a06c1230b'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '954cb0bb9d8b2dcf354540722d48cdd9'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '820483e29b5f382cbc0c524ca6dda501'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '384ab16513e30ec671e292905d023880'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing 'e9d92ec4215d9d3b654b58b7bdb9d0ce'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing 'd1a2d65abdfb292c0f9c1ce3944624f4'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '7dc52ea8c512f5bc67e1f78d07491b3b'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing 'a63edcd522ff689b1fcb7c7836a90454'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing '2063bbaf216cd222b28aeef5621c29cb'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5 
--
Analyzing 'f0faaeccc4906016212b612f6d017de1'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
[+] MD4 [JtR Format: raw-md4]
[+] Double MD5
```

Now I know that all hashed are using MD5 format. Can now proseed to John:

