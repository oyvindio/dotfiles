#!/usr/bin/env bash
# Enables the same bash completion for simple single-command shorthand aliases like `alias g=git` if the command being aliased has a completion function defined.
# Usage: source into your shell after aliases are defined and after bash_completion is sourced.

extglob_status=$(shopt -p extglob)
shopt -s extglob

mapfile -t completions < <(complete -p)
mapfile -t aliases < <(alias -p)

for token in "${aliases[@]}"
do
    alias_stripped=${token#alias }
    alias_name=${alias_stripped%%=+([^[:cntrl:]=])}
    alias_value=${alias_stripped##+([^[:cntrl:]=])=\'};
    alias_value=${alias_value%\'}

    if [[ ${alias_value} =~ ^[^[:cntrl:][:space:]\;]+$ ]]
    then # $alias_name points to a single command $alias_value with no args
        for completion in "${completions[@]}"
        do
            completion_tokens=($completion)
            completion_target=${completion_tokens[-1]}
            if [[ ${completion_target} == "${alias_value}" ]]
            then # $alias_value has a completion function, use it for $alias_name also
                complete_command=${completion_tokens[*]:0:${#completion_tokens[@]}-1}
                # echo "eval \"$complete_command $alias_name\""
                eval "$complete_command $alias_name"
            fi
        done
    fi
done

eval "$extglob_status" # set extglob option back to previous state
