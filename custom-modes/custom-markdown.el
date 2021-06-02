;;
;; Customized Markdown
;;
(el-get-bundle pandoc-mode
  :post-init
  (progn
    ))

(el-get-bundle markdown-mode
  :post-init
  (progn
    (setq markdown-enable-math t)
    (add-hook 'markdown-mode-hook 'pandoc-mode)))
