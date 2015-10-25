;; init.el

;; custom initialization
(load-file "~/.emacs.d/init.d/start-emacs.el")
(load-file "~/.emacs.d/init.d/ido-config.el")
(load-file "~/.emacs.d/init.d/set-path.el")

;;
;; el-get
;;
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; set package initialization path
(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

;; default set of packages to be installed

;; general utilities
(el-get-bundle with-eval-after-load-feature)
(el-get-bundle smex)
(el-get-bundle flx (flx-ido-mode t))
(el-get-bundle color-theme-zenburn
  (progn
    (defun load-theme-zen ()
      (load-theme 'zenburn t))
    (add-hook 'after-init-hook #'load-theme-zen)))


;; developement utilities
(el-get-bundle magit)
(el-get-bundle rainbow-delimiters
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(el-get-bundle flycheck)


;; haskell utilities
(el-get-bundle haskell-mode)
(el-get-bundle flycheck-haskell
  (with-eval-after-load-feature 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)))


;; javascript utilities
(el-get-bundle js2-mode
  (progn
    (autoload 'js2-mode "js2" nil t)
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))))
(el-get-bundle json-mode)
(el-get-bundle web-mode)