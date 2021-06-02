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
