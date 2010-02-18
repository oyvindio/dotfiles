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

;; enable column numbers
(column-number-mode t)

;; keybinds
;------------------------------------------------------------------------------
(global-set-key (kbd "C-x c") 'comment-or-uncomment-region)
(global-set-key  [C-tab] 'other-window)
(global-set-key (kbd "C-R") 'replace-string)
(global-set-key (kbd "C-c C-g") 'gist-buffer-confirm)

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

;; source: http://www.emacswiki.org/emacs/InsertAnyDate
(require 'calendar)
(defun insdate-insert-any-date (&optional days)
  (interactive "p*")
  (insert
   (calendar-date-string
    (calendar-gregorian-from-absolute
     (+ (calendar-absolute-from-gregorian (calendar-current-date))
        days)))))

;; source: http://www.emacswiki.org/emacs/InsertingTodaysDate
(require 'calendar)
(defun insdate-insert-current-date (&optional omit-day-of-week-p)
  "Insert today's date using the current locale.
  With a prefix argument, the date is inserted without the day of
  the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
                                omit-day-of-week-p)))

;; source: http://github.com/defunkt/emacs/blob/master/defunkt/defuns.el
(defun gist-buffer-confirm (&optional private)
  (interactive "P")
  (when (yes-or-no-p "Are you sure you want to Gist this buffer? ")
    (gist-region-or-buffer private)))