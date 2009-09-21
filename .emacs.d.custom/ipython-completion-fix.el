;; fix broken completion for ipython inside emacs
(setq ipython-completion-command-string
      "print(';'.join(__IP.Completer.all_completions('%s')))\n")