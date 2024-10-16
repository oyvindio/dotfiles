function update_vendor_configurations
    # homebrew
    for prefix in '/opt/homebrew' '/usr/local'
        set brew_cli "$prefix/bin/brew"
        if test -x $brew_cli
            $brew_cli shellenv | tee ~/.config/fish/conf.d/00_homebrew.generated.fish | source
        end
    end

    if command -sq pyenv
        pyenv init - fish | tee ~/.config/fish/conf.d/pyenv.generated.fish | source
    end
end
