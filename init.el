;;; init.el
;;;
;;; el-get
;;;

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;; Default set of packages to be installed
;;;
;;; General utilities
(el-get-bundle exec-path-from-shell
  :post-init (exec-path-from-shell-initialize))

(el-get-bundle color-theme-zenburn
  :post-init (load-theme 'zenburn t))

(el-get-bundle flx
  :post-init (flx-ido-mode t))

(el-get-bundle smex
  :post-init
  (progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
    ;; This is your old M-x.
    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))

(el-get-bundle paredit
  :post-init (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(el-get-bundle markdown-mode)

;;; Developement utilities
(el-get-bundle magit)

(el-get-bundle rainbow-delimiters
  :post-init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(el-get-bundle flycheck
  :post-init (add-hook 'prog-mode-hook #'flycheck-mode))

;;; Rust programming
(el-get-bundle rust-mode
  :post-init
  (add-hook 'rust-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c <tab>") #'rust-format-buffer))))

(el-get-bundle cargo)

(el-get-bundle flycheck-rust
  :prepare
  (load-file "~/.emacs.d/el-get/flycheck-rust/flycheck-rust.el"))

(el-get-bundle toml-mode)

;;; Initialize Emacs
(el-get-bundle start-emacs-with-min-ui
  :type github
  :pkgname "valyakuttan/start-emacs-with-min-ui"
  :depends (flx)
  :post-init
  (progn
    (init-ido-mode)
    (init-emacs)))
