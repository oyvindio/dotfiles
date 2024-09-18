set ___ls ls
if command -sq gls
    set ___ls gls
end
function l --wraps $___ls --inherit-variable ___ls
    $___ls --color=auto $argv
end

