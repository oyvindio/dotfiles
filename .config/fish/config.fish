if ! status is-interactive
    exit
end

set fish_greeting
# fish_config theme choose Solarized\ Light
fish_config theme choose 'Tomorrow Night Bright'
set fish_color_host blue
set  __fish_git_prompt_showcolorhints 1

abbr -a cp cp -iv
abbr -a rm rm -Iv
abbr -a mv mv -iv
abbr dnslookup dscacheutil -q host -a name

set -gx PAGER less
set -gx EDITOR 'emacsclient'
set -gx VISUAL $EDITOR
set -gx ALTERNATE_EDITOR '' # this makes emacsclient start the emacs daemon

fish_add_path ~/bin
fish_add_path ~/.local/bin

if test -f ~/.local.fish
    source ~/.local.fish
end
