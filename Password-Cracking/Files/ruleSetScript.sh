#!/bin/bash

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
