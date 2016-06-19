;; init.el

;; custom initialization
(load-file "~/.emacs.d/init.el.d/start-emacs.el")
(load-file "~/.emacs.d/init.el.d/ido-config.el")

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
(setq el-get-user-package-directory "~/.emacs.d/init.el.d/")


;; default set of packages to be installed
;;
;; general utilities
(el-get-bundle exec-path-from-shell)
(el-get-bundle smex)
(el-get-bundle flx)
(el-get-bundle color-theme-zenburn)
(el-get-bundle paredit)
(el-get-bundle markdown-mode)

;; developement utilities
(el-get-bundle magit)
(el-get-bundle rainbow-delimiters)
(el-get-bundle flycheck)

;; rust utilities
(el-get-bundle rust-mode)
(el-get-bundle cargo)
(el-get-bundle toml-mode)
(el-get-bundle flycheck-rust)
