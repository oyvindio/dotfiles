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
(color-theme-railscasts)
;;(color-theme-vivid-chalk)

;; highlight the current line
;(highline-mode)

;; set c indentation mode to k&r
(setq c-default-style "k&r")
(setq c-basic-offset 4) ; but with 4 spaces

;; disable visual bell
(setq visible-bell nil)


;; keybinds
;------------------------------------------------------------------------------
(global-set-key (kbd "C-x c") 'comment-or-uncomment-region)


;; defuns
;------------------------------------------------------------------------------

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
    (filename (buffer-file-name)))
    (if (not filename)
    (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
    (progn
      (rename-file name new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil))))))
