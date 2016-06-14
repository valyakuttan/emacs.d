;; init-rust-mode.el

(load-file "~/.emacs.d/el-get/flycheck-rust/flycheck-rust.el")

(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
