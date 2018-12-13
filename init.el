;;; init.el --- emacs init file
;;;
;;; el-get
;;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


;;; Initialize emacs
;;;
;;; Initialize Emacs with minimum distractions.
;;;
;;;###autoload
(defun init-emacs ()
  (progn
    (dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
      (when (fboundp mode) (funcall mode -1)))
    (setq inhibit-startup-screen t)
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t))
          backup-directory-alist
          `((".*" . ,temporary-file-directory)))

    ;; set utf-8 as default encoding
    (prefer-coding-system 'utf-8)
    (setq coding-system-for-read 'utf-8)
    (setq coding-system-for-write 'utf-8)

    ;;; Set font
    (set-frame-font "Inconsolata 14")

    (setq column-number-mode t) ;; enable column-number-mode
    (global-hl-line-mode)	;; highlight current line
    (setq scroll-step 1)    ;; keyboard scroll one line at a time
    (setq-default indent-tabs-mode nil)))

;; Rename both file and current buffer.
;;;
;;;###autoload
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

(init-emacs)


;;; Default set of packages to be installed
;;;
;;; Essential packages
(el-get-bundle color-theme-zenburn
  :post-init (load-theme 'zenburn t))

(el-get-bundle helm
  :post-init
  (with-eval-after-load "helm"
    (progn
      (require 'helm-config)
      (define-key helm-map (kbd "<tab>")
        'helm-execute-persistent-action) ;; rebind tab to run
                                         ;; persistent action
      (global-set-key (kbd "M-x") 'helm-M-x)
      (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching
                                    ;;for helm-M-x
      (helm-mode t))))

;;; Extra utilities
(el-get-bundle paredit
  :post-init (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))
(el-get-bundle markdown-mode)
(el-get-bundle rainbow-delimiters
  :post-init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(el-get-bundle company-mode
  :post-init (add-hook 'prog-mode-hook #'company-mode))
(el-get-bundle flycheck
  :post-init (add-hook 'prog-mode-hook #'flycheck-mode))
(el-get-bundle magit
  :post-init (global-set-key (kbd "C-x g") 'magit-status))
(el-get-bundle projectile
  :post-init
  (progn
    (add-hook 'prog-mode-hook #'projectile-mode)
    (with-eval-after-load "projectile"
      (define-key projectile-mode-map (kbd "C-p")
      'projectile-command-map))))


;;; Python support
(el-get-bundle elpy
 :post-init
 (progn
   (setq elpy-rpc-python-command "python3")
   (elpy-enable)))


;;; c/c++ support
(el-get-bundle company-c-headers
  :post-init
  (progn
    (add-to-list 'company-backends 'company-c-headers)))
