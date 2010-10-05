#/bin/bash
# source .bashrc
. ~/.bashrc

# load rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# enable bash completion for rvm
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
