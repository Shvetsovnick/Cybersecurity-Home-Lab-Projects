#!/bin/bash
# Generates all possible combinations of John the Ripper rule commands

commands=("sa@" "so0" "si1" "ss$" "ss5" "sS5" "st7" "sT7" "sA@" "sA4" "Az\"[0-9][0-9][0-9][0-9]\"")
rules=("")

for command in "${commands[@]}"; do
    new_rules=()
    for rule in "${rules[@]}"; do
        new_rule="$rule $command"
        new_rules+=("$new_rule")
    done
    rules+=("${new_rules[@]}")
done

for prefix in "l" "u" "c"; do
    for rule in "${rules[@]}"; do
        echo "${prefix}${rule}"
    done
done > bashSet.txt
