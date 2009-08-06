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
