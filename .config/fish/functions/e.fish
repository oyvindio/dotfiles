function e --wraps emacs
    if test -d /Applications/Emacs.app
        if ! pgrep -qf 'Emacs.app'
            for f in $argv
                if ! test -f $f
                    touch $f
                end
            end
            open -a '/Applications/Emacs.app' $argv
        else
            emacsclient -n $argv
        end
    else
        emacs -nw $args
    end
end
