;; misc
;-------------------------------------------------------------------------------

;; save all backup files in ~/.emacs-backup
(defvar backup-dir "~/.emacs-backup/")
(make-directory backup-dir t)
(setq backup-directory-alist
      `((".*" . ,backup-dir)))
(setq auto-save-file-name-transforms 
      `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat backup-dir "\\1") t)))
;;(setq auto-save-directory nil)

;; use spaces for indentation by default
(setq-default indent-tabs-mode nil)

;; set default tab size to 4
(setq default-tab-width 4)

;; set color theme
(eval-after-load "color-theme"
  '(progn (color-theme-railscasts))
  )

;;(color-theme-vivid-chalk)

;; highlight the current line
;(highline-mode)

;; set c indentation mode to k&r
(setq c-default-style "k&r")
(setq c-basic-offset 4) ; but with 4 spaces

;; disable visual bell
(setq visible-bell nil)

;; enable column numbers
(column-number-mode t)

;; ANSI colors for M-x shell
;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; Bindings for navigating shell command history
(eval-after-load 'shell
  '(progn
     (define-key shell-mode-map [up] 'comint-previous-input)
     (define-key shell-mode-map [down] 'comint-next-input)
     (define-key shell-mode-map "\C-p" 'comint-previous-input)
     (define-key shell-mode-map "\C-n" 'comint-next-input)))
