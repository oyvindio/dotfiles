#!/bin/bash
if [[ "$(uname)" =~ Darwin ]]
then
    # os x sets locale vars to non-standard values. this sometimes causes
    # encoding issues on remote machines
    export LANG=en_GB.UTF-8
    export LC_ALL=en_GB.UTF-8
    export LC_CTYPE=en_GB.UTF-8
fi

# source .bashrc
. ~/.bashrc

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# enable bash completion for rvm
[[ -r $rvm_path/scripts/completion ]] && . "$rvm_path/scripts/completion"
