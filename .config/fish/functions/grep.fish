set ___grep grep
if command -sq ggrep
    set ___grep ggrep
end
function grep --wraps $___grep --inherit-variable ___grep
    $___grep --color=auto $argv
end
