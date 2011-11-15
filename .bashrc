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

case $(uname -s) in
    Linux)
        . ~/.bash.d/linux
        ;;
    Darwin)
        . ~/.bash.d/osx
        ;;
esac

PS1='\[\033[0;34m\]\h\[\033[0;36m\] \w\[\033[0m\]'

# Add git status to prompt if __git_ps1 is available
if type -t __git_ps1 &> /dev/null
then
    PS1="$PS1"' \[\033[1;35m\]$(__git_ps1 "(%s)")\[\033[0m\]'
    export GIT_PS1_SHOWDIRTYSTATE=1
fi

export PS1="$PS1 $ "


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
if [[ -d $HOME/.virtualenvs && -x $(which virtualenvwrapper.sh) ]]
then
    export WORKON_HOME="$HOME/.virtualenvs"
    . $(which virtualenvwrapper.sh)
fi

export PAGER=less
export MANPAGER=less
export EDITOR="emacs -nw"
export VISUAL=$EDITOR
export ALTERNATE_EDITOR="" # this makes emacsclient start the emacs daemon
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export IGNOREEOF=1 # ignore 1 EOF (^D) before killing the shell
export PROMPT_DIRTRIM=3 # truncate long paths in PS1 prompt
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" # append to histfile on prompt

# colorize manpages in less
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[0;34m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end bold
export LESS_TERMCAP_so=$'\E[01;40;33m' # begin standout mode
export LESS_TERMCAP_se=$'\E[0m' # end standout mode
export LESS_TERMCAP_us=$'\E[0;36m' #begin underline
export LESS_TERMCAP_ue=$'\E[0m' # end underline

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
alias v="workon"
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'

# Useful functions
function mkcd() { mkdir "$1" && cd "$1"; }
function calc() { echo "$*" | bc; }
function hex2dec { awk 'BEGIN { printf "%d\n",0x$1}'; }
function dec2hex { awk 'BEGIN { printf "%x\n",$1}'; }
function mktar() { tar czf "${1%%/}.tar.gz" "${1%%/}/"; }
function rot13 () { echo "$@" | tr a-zA-Z n-za-mN-ZA-M; }

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

function git-pull-rebase() {
    if [ $TERM != "dumb" ]; then
        COLOR_START="\033[1;36m"
        COLOR_END="\033[0m"
    else
        COLOR_START=""
        COLOR_END=""
    fi

    if [ -z "`git status --porcelain --untracked=no`" ]; then
        echo -e $(git pull --rebase)
    else
        echo -e "$COLOR_START# working tree dirty - stashing changes$COLOR_END"
        echo -e "$(git stash)"
        echo -e "$COLOR_START# pull and rebase$COLOR_END"
        echo -e "$(git pull --rebase)"
        echo -e "$COLOR_START# applying stash$COLOR_END"
        echo -e "$(git stash apply)"
    fi
}

# cd up to a named dir in the current working directory
function upto() {
    local p="$PWD";
    while [[ $p ]];
    do
        if [[ ${p##*/} = "$1" ]];
        then
            cd "$p"; return;
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

if [[ -f $HOME/.bashrc_local ]]
then
    . ~/.bashrc_local
fi
