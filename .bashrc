# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Useful bash options
shopt -s cdable_vars      # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell          # autocorrects cd misspellings
shopt -s checkwinsize     # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist          # save multi-line commands in history as single line
shopt -s dotglob          # include dotfiles in pathname expansion
shopt -s expand_aliases   # expand aliases
shopt -s extglob          # enable extended pattern-matching features
shopt -s histappend       # append to (not overwrite) the history file
shopt -s hostcomplete     # attempt hostname expansion when @ is at the beginning ofa word
shopt -s nocaseglob       # pathname expansion will be treated as case-insensitive


# Prompt
# Colorized prompt with git branch indication
PS1='\u@\[\033[1;34m\]\h\[\033[1;36m\] \w\[\033[01;32m\]$(__git_ps1 " (%s)")\[\033[0m\] $ '

# Enable bash-completion in case it isn't already
if [ -f /etc/bash_completion ]
then
    . /etc/bash_completion
fi

# Set dircolors
if [ -x /usr/bin/dircolors ]
then
    eval "`dircolors -b`"
fi

# enable compleat, if installed
if [ -f /usr/local/share/compleat-1.0/compleat_setup ]
then
    . /usr/local/share/compleat-1.0/compleat_setup
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
export PATH=$PATH:/usr/local/bin
if [[ -d $HOME/.local/bin ]]; then
    export PATH=$HOME/.local/bin:$PATH
fi
if [[ -d $HOME/.local/lib/android-sdk-linux/tools ]]; then
    export PATH=$PATH:$HOME/.local/lib/android-sdk-linux/tools
fi

if [[ -d /usr/lib/jvm/java-6-sun ]]; then
    export JAVA_HOME="/usr/lib/jvm/java-6-sun"
fi

export PAGER=less
export MANPAGER=less
export BROWSER=firefox
export EDITOR="emacsclient -nw"
export VISUAL=$EDITOR
export ALTERNATE_EDITOR="" # this makes emacsclient start the emacs daemon
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export OOO_FORCE_DESKTOP="gnome soffice"
export XDG_DATA_HOME="$HOME/.local/share"
export IGNOREEOF=1 # ignore 1 EOF (^D) before exiting
export GIT_PS1_SHOWDIRTYSTATE=1 # indicate uncommitted changes in prompt
export PROMPT_DIRTRIM=3 # truncate long paths in PS1

# colors for manpages in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Useful aliases
alias ..="cd .."
alias ls='ls --color=auto'                      # add colors
alias ll='ls -lh'                               # long listing
alias la='ls -lah'                              # include hidden files
alias lr='ls -lRh'                              # recursive ls
alias screen='screen -U'
alias grep="grep -n --color=auto"               # add line numbers and colors
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias hist='history | grep $1'                  # search trough bash history
alias e="emacsclient -nw"
alias ex="emacsclient -c -n"
alias ag='apt-get'
alias ac='apt-cache'
alias gh='github'
alias go='gnome-open'

#alias ff-dev="/usr/bin/firefox -no-remote -P extdev"

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

# send ssh public key to some remote host
function sendkey () {
    if [ -f ~/.ssh/id_rsa.pub ]
    then
        if [ $# -gt 0 ]
        then
            ssh $1 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub
        fi
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
                *.bz2)      bunzip2 -v $arg   ;;
                *.rar)      unrar x $arg      ;;
                *.gz)       gunzip -v $arg    ;;
                *.tar)      tar xvf $arg      ;;
                *.tbz2)     tar xjvf $arg     ;;
                *.tgz)      tar xzvf $arg     ;;
                *.zip)      unzip $arg        ;;
                *.jar)      jar xvf $arg      ;;
                *.Z)        uncompress $arg   ;;
                *.xpi)      unzip $arg        ;;
                *.7z)       7z x $arg         ;;
                *.crx)       unzip $arg        ;;
                *)          echo "'$arg' cannot be extracted via x (extract)" ;;
            esac
        else
            echo "'$arg' is not a valid file"
        fi
    done
}

# send a libnotify notification based on exit status when a command finishes
function notify () {
    ($@)
    if [ $? = 0 ]
    then
        notify-send -i face-smile-big "$@ finished successfully!"
    else
        notify-send -i face-angry -u critical "$@ failed!"
    fi
}
