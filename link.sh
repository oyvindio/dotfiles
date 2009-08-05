#!/bin/bash

################################################################################
# Symlinks config files specified in config.sh to ~/                           #
################################################################################

. config.sh

ACTION_CLEAN="clean"
ACTION="$1"
SRC="$(pwd)/$(dirname $0)"

# remove a link, if it exists
function rm_file() {
    if [ -h "~/$1" ]
    then
        rm -v "~/$1"
    fi    
}

# link a file, unless it exists
function link_file() {
    file="$SRC/$dotfile"

    if [ -h "~/$1" ]
    then
        echo "~/$1 is already linked!"
    else
        if [ ! -e "~/$1" ]
        then
            ln -sv "$file" "~/"
        else
            echo "~/$1 already exists, remove it first!"
        fi
    fi
}

for dotfile in "${DOTFILES[@]}"
do
    case "$ACTION" in
        "$ACTION_CLEAN")
        rm_file "$dotfile"
        ;;
        *)
        link_file "$dotfile"
        ;;
    esac
done
