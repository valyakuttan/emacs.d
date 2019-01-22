;;; init.el --- Emacs startup configuration.
;;

;;; Commentary:
;;
;; el-get config info for Emacs startup
;;

;;; Code:

;;
;; el-get initialization
;;
(package-initialize)
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;
;; essential packages
;;
(el-get-bundle valyakuttan/start-emacs-with-min-ui
  :post-init (init-emacs))

(el-get-bundle exec-path-from-shell
  :post-init (exec-path-from-shell-initialize))

(el-get-bundle color-theme-zenburn
  :post-init (load-theme 'zenburn t))

(el-get-bundle helm
  :post-init
  (progn
    (with-eval-after-load "helm"
      (require 'helm-config)
      (define-key helm-map (kbd "<tab>")
        ;; rebind tab to run persistent action
        'helm-execute-persistent-action)
      (global-set-key (kbd "M-x") 'helm-M-x)
      (setq helm-M-x-fuzzy-match t))
    (helm-mode t)))

(el-get-bundle paredit
  :post-init
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(el-get-bundle clean-aindent
  :post-init (add-hook 'prog-mode-hook #'clean-aindent-mode))

(el-get-bundle markdown-mode)

(el-get-bundle rainbow-delimiters
  :post-init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(el-get-bundle company-mode
  :post-init
  (add-hook 'prog-mode-hook #'company-mode))

(el-get-bundle flycheck
  :post-init
  (add-hook 'prog-mode-hook #'flycheck-mode))

(el-get-bundle magit
  :post-init (global-set-key (kbd "C-x g") 'magit-status))

(el-get-bundle projectile
  :post-init
  (with-eval-after-load "projectile"
    (add-hook 'prog-mode-hook #'projectile-mode)
    (define-key projectile-mode-map (kbd "C-p")
      'projectile-command-map)))

;;
;; python development
;;
(el-get-bundle elpy
 :post-init (elpy-enable))

(el-get-bundle company-anaconda
  :post-init
  (with-eval-after-load "company"
    (add-to-list 'company-backends 'company-anaconda)
    (add-hook 'python-mode-hook #'anaconda-mode)))

;;
;; c/c++ development
;;
(el-get-bundle company-c-headers
  :post-init
  (with-eval-after-load "company"
    (setq company-backends
          (delete 'company-semantic company-backends))
    (add-to-list 'company-backends 'company-c-headers)))

;;
;; javascript development
;;
(el-get-bundle js2-mode
  :post-init
  (progn
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    (with-eval-after-load "js2-mode"
      ;; Better imenu
      (add-hook 'js2-mode-hook #'js2-imenu-extras-mode))))

(el-get-bundle js2-refactor
  :post-init
  (with-eval-after-load "js2-mode"
    (add-hook 'js2-mode-hook #'js2-refactor-mode)
    (js2r-add-keybindings-with-prefix "C-c C-r")
    (define-key js2-mode-map (kbd "C-k") #'js2r-kill)))

(el-get-bundle rjsx-mode)

(provide 'init)
;;; init.el ends here
