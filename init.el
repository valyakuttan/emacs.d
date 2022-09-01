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

;; location of customized modes
(add-to-list 'load-path (locate-user-emacs-file "custom-modes"))

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

; keep a list of recently opened files
(recentf-mode 1)


(el-get-bundle dash
  :post-init
  (with-eval-after-load "dash"
    (global-dash-fontify-mode)))


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
        (setq helm-M-x-fuzzy-match t)
        (setq helm-ff-file-name-history-use-recentf t))
      (helm-mode t))))


(el-get-bundle flycheck
  :post-init
  (progn
    (add-hook 'prog-mode-hook #'flycheck-mode)))


(el-get-bundle flycheck-color-mode-line
  :post-init
  (with-eval-after-load "flycheck"
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))


(el-get-bundle helm-c-flycheck
  :post-init
  (with-eval-after-load "flycheck"
    (define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck)))


(el-get-bundle company-mode
  :post-init
  (progn
    (with-eval-after-load "company"
      (setq company-tooltip-align-annotations t
            company-idle-delay 0.2
            ;; min prefix of 2 chars
            company-minimum-prefix-length 3
            company-require-match nil))
    (add-hook 'prog-mode-hook #'global-company-mode)))


(el-get-bundle helm-company
  :post-init
  (progn
    (with-eval-after-load "company"
      (define-key company-mode-map (kbd "C-:") 'helm-company)
      (define-key company-active-map (kbd "C-:") 'helm-company))))


(el-get-bundle projectile
  :post-init
  (progn
    (with-eval-after-load "projectile"
      (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
      (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
    (projectile-mode +1)))


(el-get-bundle helm-projectile
  :post-init (helm-projectile-on))


(el-get-bundle paredit
  :post-init
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))


(el-get-bundle rainbow-delimiters
  :post-init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


(el-get-bundle magit
  :post-init (global-set-key (kbd "C-x g") 'magit-status))


;; customized python mode
(load  "custom-cmode")


;; customized python mode
(load  "custom-python")

;; customized latex
;;(load  "custom-latex")

;; customized markdown
(load  "custom-markdown")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(compat)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
