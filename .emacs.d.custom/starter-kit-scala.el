;; starter-kit-scala.el

; load scala-mode
(add-to-list 'load-path (concat user-specific-dir "/scala-mode"))
(require 'scala-mode-auto)

; hook yasnippets to scala-mode
(require 'yasnippet-bundle)
(add-hook 'scala-mode-hook
          '(lambda ()
             (yas/minor-mode-on)))

; load scala-mode automagically for .scala files
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
