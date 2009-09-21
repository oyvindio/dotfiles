;; Bind C-c C-v to "go to next error and show error menu"
(defun my-flymake-show-next-error()
;  (interactive)
    (flymake-goto-next-error)
    (flymake-display-err-menu-for-current-line))
(local-set-key "\C-c\C-c" 'my-flymake-show-next-error)

;; Run pyflymake (pylint, pyflakes and pep8) on python files with flymake
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pyflymake"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))