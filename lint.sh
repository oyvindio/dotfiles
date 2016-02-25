#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
FILES=($(find .bash.d .bash_completion.d .bashrc .bash_profile .bash_completion lint.sh setup-osx.sh -type f))
shellcheck --shell=bash --format=gcc "${FILES[@]}"
