if ! status is-interactive
    exit
end

set fish_greeting
fish_config theme choose Solarized\ Light
set fish_color_host blue
set  __fish_git_prompt_showcolorhints 1

abbr -a cp cp -iv
abbr -a rm rm -iv
abbr -a mv mv -iv
abbr dnslookup dscacheutil -q host -a name

set -gx PAGER less
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

# ignore one EOF/C-d, similar to IGNOREEOF=1 in bash
bind \cd delete-char
bind \cd\cd delete-or-exit

# fun emacs bindings
bind \cx\cf 'emacsclient --no-wait --eval "(select-frame-set-input-focus (selected-frame))" "(counsel-projectile-find-file)"; commandline -f repaint'
bind \cxg 'emacsclient --no-wait --eval "(select-frame-set-input-focus (selected-frame))" "(magit-status)"; commandline -f repaint'

fish_add_path ~/bin
fish_add_path ~/.local/bin

if test -f ~/.local.fish
    source ~/.local.fish
end
