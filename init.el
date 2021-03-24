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


;;; Set font
(set-frame-font "Inconsolata 14")


;;; Default set of packages to be installed
;;;
;;; Essential packages
(el-get-bundle exec-path-from-shell
  :post-init (when (memq window-system '(mac ns x))
               (exec-path-from-shell-initialize)))

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
        (global-set-key (kbd "C-x C-f") 'helm-find-files)
        (setq helm-M-x-fuzzy-match t)))
    (helm-mode t)))

(el-get-bundle paredit
  :post-init
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(el-get-bundle markdown-mode)

(el-get-bundle rainbow-delimiters
  :post-init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(el-get-bundle magit
  :post-init (global-set-key (kbd "C-x g") 'magit-status))

(el-get-bundle company-mode
  :post-init
  (setq company-tooltip-align-annotations t
        company-idle-delay 0.2
        ;; min prefix of 2 chars
        company-minimum-prefix-length 2
        company-require-match nil)
  (add-hook 'prog-mode-hook #'company-mode))

(el-get-bundle flycheck
  :post-init (add-hook 'prog-mode-hook #'flycheck-mode))

;;; Python support
(el-get-bundle elpy
 :post-init
 (progn
   (setq python-shell-interpreter "pipenv"
         python-shell-interpreter-args "run python"
         python-shell-prompt-detect-failure-warning nil)
   (setq elpy-rpc-backend "jedi")
   (setq elpy-shell-starting-directory 'current-directory)
   (setq python-indent-offset 4)
   (with-eval-after-load "python"
     '(add-to-list 'auto-mode-alist '("\\.py$" . python-mode)))
   (elpy-enable)))

(el-get-bundle elpa:jedi-core)
(el-get-bundle company-jedi
  :depends (company-mode)
  :post-init
  (progn
    (defun enable-jedi()
      (setq-local company-backends
                  (append '(company-jedi) company-backends)))
    (with-eval-after-load "company"
      (add-hook 'python-mode-hook 'enable-jedi))))


;;; c/c++ support
(el-get-bundle company-c-headers
  :post-init
  (progn
    (with-eval-after-load "company"
      '(add-to-list 'company-backends 'company-c-headers))))
