#!/bin/bash

################################################################################
# Symlinks config files specified in config.sh to $HOME/                       #
################################################################################

. config.sh

ACTION_CLEAN="clean"
ACTION_HELP="help"

SRC="$(pwd)/$(dirname $0)"

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
        echo "$HOME/$1 is already linked!"
    else
        if [ ! -e "$HOME/$1" ]
        then
            ln -sv "$file" "$HOME/"
        else
            echo "$HOME/$1 already exists, remove it first!"
        fi
    fi
}

for dotfile in "${DOTFILES[@]}"
do
    case "$1" in
        "$ACTION_CLEAN")
        rm_file "$dotfile"
        ;;
        *)
        link_file "$dotfile"
        ;;
    esac
done
