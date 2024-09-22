if test -d '/Applications/Emacs.app'
    function e --wraps emacsclient
        if ! pgrep -qf 'Emacs.app'
            for f in $argv; do
                if ! test -f $f
                    touch $f
                end
            end
            open -a '/Applications/Emacs.app' $argv
        else
            emacsclient -n $argv
        end
    end
else
    function e --wraps emacs
        emacs -nw $argv
    end
end
