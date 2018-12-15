;;; init.el --- emacs init file
;;;
;;; el-get
;;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't
;; want it,
;; just comment it out by adding a semicolon to the start of the
;; line.
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
(el-get-bundle valyakuttan/start-emacs-with-min-ui
  :post-init (init-emacs))


;;; Default set of packages to be installed
;;;
;;; Essential packages
(el-get-bundle color-theme-zenburn
  :post-init (load-theme 'zenburn t))

(el-get-bundle helm
  :post-init
  (progn
    (with-eval-after-load "helm"
      (progn
        (require 'helm-config)
        (define-key helm-map (kbd "<tab>")
          'helm-execute-persistent-action) ;; rebind tab to run
                                           ;; persistent action
        (global-set-key (kbd "M-x") 'helm-M-x)
        (setq helm-M-x-fuzzy-match t)))
    (helm-mode t)))

(el-get-bundle paredit
  :post-init
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(el-get-bundle markdown-mode)

(el-get-bundle rainbow-delimiters
  :post-init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

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
   (elpy-enable)))

(el-get-bundle company-anaconda
  :post-init
  (progn
    (eval-after-load "company"
      '(add-to-list 'company-backends 'company-anaconda))
    (add-hook 'python-mode-hook 'anaconda-mode)))

;;; c/c++ support
(el-get-bundle company-c-headers
  :post-init
  (progn
    (eval-after-load "company"
      '(add-to-list 'company-backends 'company-c-headers))))
