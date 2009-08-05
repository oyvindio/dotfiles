#!/bin/bash

WD=$(dirname "$0")
cd "$WD"

ACTION="$1"
ACTION_CLEAN="clean"

DOTFILES=$(find . -maxdepth 1 -name ".*" ! -name ".git")

# remove a link, if it exists
function rm_file() {
    file="$WD/$dotfile"

    if [ -h "$1" ]
    then
        rm -v "$1"
    fi    
}

function link_file() {
    file="$WD/$dotfile"

    if [ -h "$1" ]
    then
        echo "$1 is already linked!"
    fi
        
    dst="/tmp/dotfiles"
    if [ ! -e "$1" ]
    then
        ln -s "$file" "$dst/$1"
    else
        echo "$dst/$1 already exists, remove it first!"
    fi
}

function create_editor_backup_dirs() {
    dst="/tmp/dotfiles"
    for dir in "$dst/.vim-backup $dst/.emacs-backup"
    do
        if [ ! -d "$dir" ]
        then
            mkdir -v "$dir"
        fi
    done
}

for dotfile in "$DOTFILES"
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

create_editor_backup_dirs
