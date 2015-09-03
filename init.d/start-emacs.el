;; start-emacs.el

;;
;; no frills
;;
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-screen t)

;;
;; no junk
;;
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t))
      backup-directory-alist `((".*" . ,temporary-file-directory)))

;;
;; some useful initialization
;;
(setq column-number-mode t)      ;; enable column-number-mode
(global-hl-line-mode)	         ;; highlight current line
(setq scroll-step 1)             ;; keyboard scroll one line at a time
(setq-default indent-tabs-mode nil) ;; deactivate tab indenting
(require 'cl)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (flet ((process-list ())) ad-do-it))

;;
;; Some helper functions
;;
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
