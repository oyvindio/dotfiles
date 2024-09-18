if not status is-interactive
    exit
end

set fish_greeting

set -gx PAGER less
set -gx MANPAGER $PAGER
set -gx EDITOR 'emacsclient'
set -gx VISUAL $EDITOR
set -gx ALTERNATE_EDITOR '' # this makes emacsclient start the emacs daemon

# colorize man pages in less
set -gx LESS_TERMCAP_mb \e'[01;31m' # begin blinking
set -gx LESS_TERMCAP_md \e'[0;34m' # begin bold
set -gx LESS_TERMCAP_me \e'[0m' # end bold
set -gx LESS_TERMCAP_so \e'[01;40;33m' # begin standout mode
set -gx LESS_TERMCAP_se \e'[0m' # end standout mode
set -gx LESS_TERMCAP_us \e'[0;36m' #begin underline
set -gx LESS_TERMCAP_ue \e'[0m' # end underline

# export LS_COLORS (GNU ls) for readline, and set LSCOLORS (BSD) to match it (as closely as possible)
set -gx LSCOLORS 'exfxcxdxbxegedabagacad'
set -gx LS_COLORS 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:or=35;7:su=31;7:sg=36;7:tw=32;7:ow=33;7:'

abbr -a cp cp -iv
abbr -a mv mv -iv
abbr -a rm rm -iv

if test -d ~/bin
    fish_add_path ~/bin
end

if test -f ~/.local.fish
    source ~/.local.fish
end
