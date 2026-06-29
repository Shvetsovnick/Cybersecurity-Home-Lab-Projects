## Objective
Exploring Password Cracking Techniques Using John the Ripper

### Tools used: 

- ```John the Ripper```, ```hashid```, ```cut```

  Metri

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
First I run the provided hashes against a standard wordlist (rockyou.txt).
To use John the Ripper I first needed to identify the hash type.  
The hashes were stored in the format ``` username:hash ```, so I needed to extract only the hash values.  

```
┌──(kali㉿kali)-[~/Git/Password-Cracking/Files]
└─$ cut -d: -f2 hashes > separatedHashes
```
I extracted the hash values to simplify further identification and testing. 

Hash identification tools like ```hashid``` provide multiple possible matches. Need to verify whether all  hashes were in the same format:
```
┌──(kali㉿kali)-[~/Git/Password-Cracking/Files]
└─$ hashid -j separatedHashes |grep -B 2 -E "MD5" 
Analyzing '66014792c8b3bdd74684696f5c46a75c'
[+] MD2 [JtR Format: md2]
[+] MD5 [JtR Format: raw-md5]
...
```

All hashes appeared consistent with raw-MD5, so I continued with John using ```--format=raw-md5```

```
┌──(kali㉿kali)-[~/Git/Cybersecurity-Home-Lab-Projects/Password-Cracking/Files] 
└─$ john --wordlist=/usr/share/wordlists/rockyou.txt --format=Raw-MD5 hashes 

brontosaurus     (JoeyJoeJoe)     

Session completed.
```

The initial run has allowed me to crack one password. Based on the provided information I use file ```dinos.txt``` containing over 1500 dinosaur names as a wordlist and also copy ```/etc/john/john.conf``` to create custom rules. 
I need to create a rule, that specifies every possible scenario using leet speak substitution and adding 4 digits to the end of the password. 
The original  leetspeak alphabet contains about 68 characters or (group of characters) to represent every letter of English alphabet. For the purpose of this writeup I will use the most common characters:
a-@ o-0 i-1 s-$ s-5 S-5 t-7 T-7 A-@ A-4
I will create a Bash script to generate possible combinations for my rule. 

```
#!/bin/bash
# Generates all possible combinations of John the Ripper rule commands

commands=("l" "sa@" "sE3" "so0" "si1" "ss$" "sS$" "st7" "sT7" "sA4" "Az\"[0-9][0-9][0-9][0-9]\"")
rules=("")

for command in "${commands[@]}"; do
new_rules=()
for rule in "${rules[@]}"; do
        new_rule="$rule $command"
        new_rules+=("$new_rule")
   done
   rules+=("${new_rules[@]}")
 done

for rule in "${rules[@]}"; do
        echo $rule
   done > rules.txt


```
Need to make this script executable 

``` chmod +x ruleSetScript.sh ```

After running this script creates a ```rules.txt``` file containing the ruleset I need for modifying config file.
Now in the config file that I copied before I will add a custom ruleset under Rules section

```
[List.Rules:Dinos]
┌──(kali㉿kali)-[~/Git/Cybersecurity-Home-Lab-Projects/Password-Cracking/Files]
└─$ cat johnRedacted.conf| grep Dinos -A 100
[List.Rules:Dinos]
:
l
u
c
 l
 sa@
 so0
 si1
 ss$
...
``` 
Now I need to run John with updated rules and see if I can crack remaining hashes. I  saved cracked passwords to file Passwords.txt

```
┌──(kali㉿kali)-[~/Git/Cybersecurity-Home-Lab-Projects/Password-Cracking/Files]
└─$ john --wordlist=dinos.txt --rules=Dinos --config=johnRedacted.conf --format=raw-md5 hashes 

┌──(kali㉿kali)-[~/Git/Cybersecurity-Home-Lab-Projects/Password-Cracking/Files]
└─$ john --show --format=raw-md5 hashes > Passwords.txt
```

### Results
---

Total hashes: 13
Cracked with standart wordlist: 1
Cracked with custom rules modification: 12
Success rate: 100%


Using John the Ripper, I was able to successfully crack multiple password hashes from the provided dataset.


The initial dictionary attack using rockyou.txt resulted in 1 cracked password
A targeted attack using a custom wordlist (dinosaur names) combined with rule-based transformations significantly improved results
Applying leetspeak substitutions and appending 4-digit numeric patterns proved to be the most effective strategy.

The rule generation script creates all combinations, which leads to inefficient rule sets.
In real-world scenarios, a more targeted approach would be preferred to reduce noise and improve performance.


### Lessons Learned
---

This exercise shows that even when passwords meet common complexity requirements 
(e.g. uppercase, digits, symbols), they remain weak if they follow predictable patterns.

Patterns observed:
- base word + 4 digits (very common)
- limited leetspeak substitutions (a→@, e→3, o→0)
- no randomness in structure

From an attacker’s perspective:
- rule-based attacks outperform pure dictionary attacks when patterns are known
- small, targeted wordlists combined with custom rules are highly effective

From a defensive perspective:
- password complexity rules alone are insufficient
- password policies should discourage predictable transformations
- MFA significantly reduces risk even if password is compromised



