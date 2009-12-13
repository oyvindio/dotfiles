#!/bin/bash

################################################################################
# Symlinks config files specified in config.sh to $HOME/                       #
################################################################################

shopt -s extglob
shopt -s dotglob

ACTION_CLEAN="clean"
ACTION_DRY_RUN="dry-run"

DOTFILE_GLOB=!(\.git|\.gitmodules|link\.sh|README\.markdown)

if [ "$(dirname $0)" == "." ]
then
    SRC="$(pwd)"
else
    SRC="$(pwd)/$(dirname $0)"
fi

# remove a link, if it exists
function rm_file() {
    if [ -h "$HOME/$1" ]
    then
        rm -v "$HOME/$1"
    fi    
}

# link a file, unless it exists
function link_file() {
    file="$SRC/$1"
    dst="$HOME/$1"

    if [ "$1" == ".Xdefaults" ]
    then
        dst="$HOME/$1-$(hostname)"
    fi

    if [ -h "$dst" ]
    then
        ln -snvf "$file" "$dst"
    else
        if [ ! -e "$dst" ]
        then
            ln -snv "$file" "$dst"
        else
            echo "$dst already exists, remove it first!"
        fi
    fi
}

function update_emacs-starter-kit() {
    pushd "$SRC"
    rm -v "$SRC/.emacs.d/$USER"

    git submodule init
    git submodule update

    ln -snvf "$SRC/.emacs.d.custom" "$SRC/.emacs.d/$USER"
    popd
}

case "$1" in
    "$ACTION_CLEAN")
        for dotfile in $DOTFILE_GLOB
        do
            rm_file "$dotfile"
        done
        ;;
    "$ACTION_DRY_RUN")
        for dotfile in $DOTFILE_GLOB
        do
            echo "will be linked: $dotfile"
        done
        ;;
    *)
        update_emacs-starter-kit
        for dotfile in "$DOTFILE_GLOB"
        do
            link_file "$dotfile"
        done
        ;;
esac