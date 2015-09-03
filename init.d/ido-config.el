;; ido-config.el

(require 'ido)

(ido-mode t)
(ido-everywhere t)

(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-default-buffer-method 'other-window)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)
