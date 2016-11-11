#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
if [[ "$TRAVIS" == "true" ]]; then
    SHELLCHECK="docker run --rm -it -v $(pwd):/mnt koalaman/shellcheck:latest"
else
    SHELLCHECK='shellcheck'
fi
FILES=($(find .bash.d .bash_completion.d .bashrc .bash_profile .bash_completion lint.sh setup-osx.sh -type f))
$SHELLCHECK --shell=bash --format=gcc "${FILES[@]}"
