#!/usr/bin/env bash
# Enables the same bash completion for simple single-command shorthand aliases like `alias g=git`
# if the command being aliased has a completion function defined.
# Usage: source into your shell after aliases are defined and after bash_completion is sourced.

extglob_status=$(shopt -p extglob)
shopt -s extglob

while read -r token
do
    alias_stripped=${token#alias }
    alias_name=${alias_stripped%%=+([^[:cntrl:]=])}
    alias_value=${alias_stripped##+([^[:cntrl:]=])=\'};
    alias_value=${alias_value%\'}

    if [[ ${alias_value} =~ ^[^[:cntrl:][:space:]\;]+$ ]]
    then # $alias_name points to a single command $alias_value with no args
        alias_value_complete=$(complete -p "$alias_value" 2> /dev/null)
        if [[ $? == 0 ]]
        then
            complete_command=${alias_value_complete% +([^[:cntrl:]])}
            # echo "eval \"$complete_command $alias_name\""
            eval "$complete_command $alias_name"
        fi
    fi
done < <(alias -p)

eval "$extglob_status" # set extglob option back to previous state
