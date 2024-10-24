function man --wraps man
    set -x PAGER less
    set -x LESS_TERMCAP_mb \e'[01;31m' # begin blinking
    set -x LESS_TERMCAP_md \e'[0;34m' # begin bold
    set -x LESS_TERMCAP_me \e'[0m' # end bold
    set -x LESS_TERMCAP_so \e'[01;40;33m' # begin standout mode
    set -x LESS_TERMCAP_se \e'[0m' # end standout mode
    set -x LESS_TERMCAP_us \e'[0;36m' #begin underline
    set -x LESS_TERMCAP_ue \e'[0m' # end underline
    command man $argv
end
