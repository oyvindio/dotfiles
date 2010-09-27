# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# tty flow control (^s and ^q) is more trouble than it's worth; disable it
stty -ixon -ixoff

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

# Colorized prompt with git branch indication
PS1='\u@\[\033[1;34m\]\h\[\033[1;36m\] \w\[\033[01;32m\]$(__git_ps1 " (%s)")\[\033[0m\] $ '

case $(uname -s) in
    Linux)
        . ~/.bashrc_linux
        ;;
    Darwin)
        . ~/.bashrc_osx
        ;;
esac

# Set dircolors
if [[ -x /usr/bin/dircolors ]]
then
    eval "`dircolors -b`"
fi

# enable completion for pip
if [[ -x $(which pip) ]]
then
    eval "`pip completion --bash`"
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
# use virtualenvwrapper
if [[ -d $HOME/.virtualenvs ]]; then
    export WORKON_HOME="$HOME/.virtualenvs"
    . /usr/local/bin/virtualenvwrapper.sh
fi

export PAGER=less
export MANPAGER=less
export EDITOR="emacsclient -nw"
export VISUAL=$EDITOR
export ALTERNATE_EDITOR="" # this makes emacsclient start the emacs daemon
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export IGNOREEOF=1 # ignore 1 EOF (^D) before killing the shell
export GIT_PS1_SHOWDIRTYSTATE=1 # indicate uncommitted git changes in prompt
export PROMPT_DIRTRIM=3 # truncate long paths in PS1 prompt

# colorize manpages in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Useful aliases
alias ..="cd .." # lazy
alias ll='ls -lh' # long listing
alias la='ls -lah' # include hidden files
alias lr='ls -lRh' # recursive ls
alias cp='cp -iv' # verbose + idiot proofing...
alias mv='mv -iv' # verbose + idiot proofing...
alias rm='rm -iv' # verbose + idiot proofing...
alias e="emacsclient -nw" # open emacs on the commandline
alias ex="emacsclient -c -n" # open an emacs window

# Useful functions
function mkcd() { mkdir "$1" && cd "$1"; }
function calc() { echo "$*" | bc; }
function hex2dec { awk 'BEGIN { printf "%d\n",0x$1}'; }
function dec2hex { awk 'BEGIN { printf "%x\n",$1}'; }
function mktar() { tar czf "${1%%/}.tar.gz" "${1%%/}/"; }
function rot13 () { echo "$@" | tr a-zA-Z n-za-mN-ZA-M; }
function myip() { wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1; }

function instaweb() {
    if [ $# -gt 0 ]
    then
        if [ -d "$1" ]
        then
            cd "$1"
            python -m SimpleHTTPServer
            cd -
        else
            python -m SimpleHTTPServer "$1"
        fi
    else
        python -m SimpleHTTPServer
    fi
}

# extract files based on file extension
function x() {
    for arg in $@
    do
        if [ -f $arg ]
        then
            case $arg in
                *.tar.bz2)  tar xjvf $arg     ;;
                *.tar.gz)   tar xzvf $arg     ;;
                *.tar.xz)   tar xJvf $arg     ;;
                *.bz2)      bunzip2 -v $arg   ;;
                *.rar)      unrar x $arg      ;;
                *.gz)       gunzip -v $arg    ;;
                *.tar)      tar xvf $arg      ;;
                *.tbz2)     tar xjvf $arg     ;;
                *.tgz)      tar xzvf $arg     ;;
                *.txz)      tar xJvf $arg     ;;
                *.zip)      unzip $arg        ;;
                *.jar)      jar xvf $arg      ;;
                *.Z)        uncompress $arg   ;;
                *.xpi)      unzip $arg        ;;
                *.7z)       7z x $arg         ;;
                *.crx)       unzip $arg       ;;
                *)          echo "'$arg' cannot be extracted via x (extract)" ;;
            esac
        else
            echo "'$arg' is not a valid file"
        fi
    done
}

