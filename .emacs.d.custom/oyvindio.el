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

;; set color theme
(color-theme-railscasts)

;; highlight the current line
;;(highline-mode)

;; set c indentation mode to k&r
(setq c-default-style "k&r")

;; disable visual bell
(setq visible-bell nil)