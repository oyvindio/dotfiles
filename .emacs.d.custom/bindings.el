;; Keybindings
;;-----------------------------------------------------------------------------
(global-set-key (kbd "C-x c") 'comment-or-uncomment-region)
(global-set-key  [C-tab] 'other-window)
(global-set-key (kbd "C-r") 'replace-string)
(global-set-key (kbd "C-c C-f") 'fill-region)
(global-set-key (kbd "C-c C-g") 'gist-buffer-confirm)
(global-set-key (kbd "C-x m") 'shell) ; rebind starter-kit eshell->shell
(global-set-key (kbd "M-s") 'ack)
