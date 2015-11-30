#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -t 1 ]; then
    stty -ixon -ixoff # disable tty flow control (^s and ^q) 
    stty werase undef # disable the ttys ^w which overrides readlines backward-kill-word
fi

# Useful bash options
shopt -s cdable_vars # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell # autocorrects cd misspellings
shopt -s checkwinsize # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob # include dotfiles in pathname expansion
shopt -s expand_aliases # expand aliases
shopt -s extglob # enable extended pattern-matching features
shopt -s histappend # append to (not overwrite) the history file
shopt -s histverify # readline goodness for history substitutions
shopt -s histreedit # allow re-editing failed history substitutions
shopt -s hostcomplete # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob # pathname expansion will be treated as case-insensitive
[[ ${BASH_VERSINFO[0]} -ge 4 ]] && shopt -s globstar # allow recursive globbing with ** (bash 4.0 and later only)

function source_if_exists() {
    for file in "$@"; do
        if [[ -f "$file" ]]; then
            . "$file"
        fi
    done
}

function command_is_defined() {
    type -t "$1" &> /dev/null
}

case $(uname -s) in
    Linux)
        # shellcheck source=.bash.d/linux
        . ~/.bash.d/linux
        ;;
    Darwin)
        # shellcheck source=.bash.d/osx
        . ~/.bash.d/osx
        ;;
esac

export PS1='\[\033[0;34m\]\h\[\033[0;36m\] \w\[\033[0m\] $ '

# Set dircolors
if [[ -x /usr/bin/dircolors ]]
then
    eval "$(dircolors -b)"
fi

SRC_HILITE_LESSPIPE=$(which src-hilite-lesspipe.sh)
if [[ ! -z ${SRC_HILITE_LESSPIPE} ]]
then
    export LESSOPEN="| ${SRC_HILITE_LESSPIPE} %s"
fi
unset SRC_HILITE_LESSPIPE
export LESS=' -R '

# enable completion for pip
if command_is_defined pip
then
    eval "$(pip completion --bash 2>/dev/null)"
fi

# Change the window title of X terminals
case $TERM in
    aterm|eterm|*xterm*|konsole|kterm|rxvt*|wterm)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/$HOME/~}\007"'
        ;;
    screen*)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}    \033\\"'
        ;;
esac

# Exports
if [[ -d "$HOME/bin" ]]
then
    export PATH="$PATH:$HOME/bin"
fi

export PAGER=less
export MANPAGER=less
export EDITOR="emacs -nw"
export VISUAL=$EDITOR
export ALTERNATE_EDITOR="" # this makes emacsclient start the emacs daemon
if ([[ ${BASH_VERSINFO[0]} -eq 4 ]] && [[ ${BASH_VERSINFO[1]} -ge 3 ]]) || [[ ${BASH_VERSINFO[0]} -gt 4 ]]; then
    export HISTSIZE=-1
    export HISTFILESIZE=-1
else
    export HISTSIZE=500000
    export HISTFILESIZE=500000
fi
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
export IGNOREEOF=1 # ignore 1 EOF (^D) before killing the shell
export PROMPT_DIRTRIM=3 # truncate long paths in PS1 prompt
#export PROMPT_COMMAND="history -a && history -c && history -r && $PROMPT_COMMAND" # append to and reread histfile on prompt
export PROMPT_COMMAND="history -a && $PROMPT_COMMAND" # append to and reread histfile on prompt
export GREP_OPTIONS="--color=auto"

# colorize manpages in less
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[0;34m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end bold
export LESS_TERMCAP_so=$'\E[01;40;33m' # begin standout mode
export LESS_TERMCAP_se=$'\E[0m' # end standout mode
export LESS_TERMCAP_us=$'\E[0;36m' #begin underline
export LESS_TERMCAP_ue=$'\E[0m' # end underline

# Python rc file
export PYTHONSTARTUP="$HOME/.pythonrc"

# Useful aliases
alias ..="cd .." # lazy
alias ll='ls -lh' # long listing
alias l=ll
alias la='ls -lah' # include hidden files
alias lr='ls -lRh' # recursive ls
alias cp='cp -iv' # verbose + idiot proofing...
alias mv='mv -iv' # verbose + idiot proofing...
alias rm='rm -iv' # verbose + idiot proofing...
alias e="emacs -nw" # open emacs on the commandline
alias ex="emacs" # open an emacs window
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
alias py-watchdog="watchmedo shell-command --patterns='*.py' --recursive --command='py.test -v'"
alias docker-rmi-untagged="docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3 | xargs docker rmi"
alias docker-rmi-dangling='docker images --filter dangling=true --quiet | xargs docker rmi'
alias docker-rm-stopped='docker ps -f status=exited -q | xargs docker rm'
alias g=git
alias dm=docker-machine
alias dcp=docker-compose
alias diga='dig +nocmd -tANY +multiline +noall +answer'

# Useful functions
function hex2dec { awk 'BEGIN { printf "%d\n",0x$1}'; }
function dec2hex { awk 'BEGIN { printf "%x\n",$1}'; }
function rot13 () { echo "$@" | tr a-zA-Z n-za-mN-ZA-M; }

# extract files based on file extension
function x() {
    for arg in "$@"
    do
        if [ -f "$arg" ]
        then
            case "$arg" in
                *.tar.bz2)  tar xjvf "$arg"     ;;
                *.tar.gz)   tar xzvf "$arg"     ;;
                *.tar.xz)   tar xJvf "$arg"     ;;
                *.bz2)      bunzip2 -v "$arg"   ;;
                *.rar)      unrar x "$arg"      ;;
                *.gz)       gunzip -v "$arg"    ;;
                *.tar)      tar xvf "$arg"      ;;
                *.tbz2)     tar xjvf "$arg"     ;;
                *.tgz)      tar xzvf "$arg"     ;;
                *.txz)      tar xJvf "$arg"     ;;
                *.zip)      unzip "$arg"        ;;
                *.jar)      jar xvf "$arg"      ;;
                *.Z)        uncompress "$arg"   ;;
                *.xpi)      unzip "$arg"        ;;
                *.7z)       7z x "$arg"         ;;
                *.crx)      unzip "$arg"        ;;
                *)          echo "'$arg' cannot be extracted via x (extract)" ;;
            esac
        else
            echo "'$arg' is not a valid file"
        fi
    done
}

# cd up to a named dir in the current working directory
function upto() {
    local p="$PWD";
    while [[ $p ]];
    do
        if [[ ${p##*/} = "$1" ]];
        then
            cd "$p" || return 1
            return;
        fi;
        p=${p%/*};
    done;
    return 1;
}

function __upto() {
    local cur
    _get_comp_words_by_ref cur
    COMPREPLY=( $( compgen -W "${PWD//\// }" -- "$cur" ) )
}
complete -o default -F __upto upto

source_if_exists ~/.bashrc_local

enable_bash_completion
unset enable_bash_completion

# Add git status to prompt if __git_ps1 is available
if command_is_defined __git_ps1
then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export PS1="${PS1% $ }"'\[\033[1;35m\]$(__git_ps1 " (%s)")\[\033[0m\] $ '
fi
