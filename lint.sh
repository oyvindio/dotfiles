#!/usr/bin/env bash
FILES=($(find .bash.d .bash_completion.d .bashrc .bash_profile .bash_completion lint.sh setup-osx.sh -type f))
shellcheck --shell=bash --format=gcc "${FILES[@]}"
