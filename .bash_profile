#!/bin/bash
if [[ "$OSTYPE" =~ darwin* ]]
then
    # os x sets locale vars to non-standard values. this sometimes causes
    # encoding issues on remote machines
    export LANG=en_GB.UTF-8
    export LC_ALL=en_GB.UTF-8
    export LC_CTYPE=en_GB.UTF-8
fi

# shellcheck source=.bashrc
. ~/.bashrc
