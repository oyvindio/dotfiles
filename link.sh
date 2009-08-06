#!/bin/bash

################################################################################
# Symlinks config files specified in config.sh to $HOME/                       #
################################################################################



ACTION_CLEAN="clean"
ACTION_HELP="help"

if [ "$(dirname $0)" == "." ]
then
    SRC="$(pwd)"
else
    SRC="$(pwd)/$(dirname $0)"
fi
. "$SRC/config.sh"

# remove a link, if it exists
function rm_file() {
    if [ -h "$HOME/$1" ]
    then
        rm -v "$HOME/$1"
    fi    
}

# link a file, unless it exists
function link_file() {
    file="$SRC/$dotfile"

    if [ -h "$HOME/$1" ]
    then
        ln -snvf "$file" "$HOME/"
    else
        if [ ! -e "$HOME/$1" ]
        then
            ln -snv "$file" "$HOME/"
        else
            echo "$HOME/$1 already exists, remove it first!"
        fi
    fi
}

case "$1" in
    "$ACTION_CLEAN")
        rm -v "$SRC/.emacs.d/$USER"
        for dotfile in "${DOTFILES[@]}"
        do
            rm_file "$dotfile"
        done
        ;;
    *)
        ln -snvf "$SRC/.emacs.d.custom" "$SRC/.emacs.d/$USER"
        for dotfile in "${DOTFILES[@]}"
        do
            link_file "$dotfile"
        done
        ;;
esac