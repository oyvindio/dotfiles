function grep --wraps grep
    command grep --color=auto $argv
end

# use gnu grep if g-prefixed binary available (macOS)
if command -sq ggrep
    function grep --wraps ggrep
        ggrep --color=auto $argv
    end
end
