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
;;; Essential packages
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

;;; Initialize Emacs
(el-get-bundle start-emacs-with-min-ui
  :type github
  :pkgname "valyakuttan/start-emacs-with-min-ui"
  :depends (flx)
  :post-init
  (progn
    (init-ido-mode)
    (init-emacs)))

;;; Extra utilities
(el-get-bundle paredit
  :post-init (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))

(el-get-bundle markdown-mode)

(el-get-bundle rainbow-delimiters
  :post-init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(el-get-bundle flycheck
  :post-init (add-hook 'prog-mode-hook #'flycheck-mode))

(el-get-bundle magit
  :post-init (global-set-key (kbd "C-x g") 'magit-status))


;;; Latex support with AUCTeX and RefTeX
;;;
;;; Customary Customization, p. 1 and 16 in the manual,
;;; and http://www.emacswiki.org/emacs/AUCTeX#toc2
(el-get-bundle auctex
  :post-init
  (progn
    (setq TeX-parse-self t); Enable parse on load.
    (setq TeX-auto-save t); Enable parse on save.
    (setq-default TeX-master nil)
    (setq TeX-PDF-mode t); PDF mode (rather than DVI-mode)

    (add-hook 'TeX-mode-hook
              (lambda () (TeX-fold-mode 1))) ; Automatically activate TeX-fold-mode.

    (add-hook 'TeX-mode-hook 'LaTeX-math-mode))) ; LaTeX-math-mode http://www.gnu.org/s/auctex/manual/auctex/Mathematics.html

;;; Turn on RefTeX for AUCTeX
;;; http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(el-get-bundle reftex
  :post-init (add-hook 'TeX-mode-hook 'turn-on-reftex))
