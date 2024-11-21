function fish_user_key_bindings
    # fun emacs bindings
    bind \cx\cf 'emacsclient --no-wait --eval "(select-frame-set-input-focus (selected-frame))" "(counsel-projectile-find-file)"; commandline -f repaint'
    bind \cxg 'emacsclient --no-wait --eval "(select-frame-set-input-focus (selected-frame))" "(magit-status)"; commandline -f repaint'
end
