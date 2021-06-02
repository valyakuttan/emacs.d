;;
;; Customized Latex
;;
(el-get-bundle reftex)
(el-get-bundle auctex
  :post-init
  (progn
    (setq TeX-auto-save t)
    (setq TeX-parse-self t)
    (setq-default TeX-master nil)
    (add-hook 'LaTeX-mode-hook 'visual-line-mode)
    (add-hook 'LaTeX-mode-hook 'flyspell-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (setq TeX-PDF-mode t)
    (setq reftex-plug-into-AUCTeX t)
    (add-hook 'LaTeX-mode-hook
                (lambda ()
                  (push
                   '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                     :help "Run latexmk on file")
                   TeX-command-list)))

    ;; latexmk for tex file processing
    (add-hook 'TeX-mode-hook '(lambda ()
                                (setq TeX-command-default "latexmk")))

    ;; evince as pdf viewer
    (add-hook 'LaTeX-mode-hook 'my-LaTeX-mode)
    (with-eval-after-load "latex"
      (defun my-LaTeX-mode()
        (add-to-list 'TeX-view-program-list
                     '("Evince" "/usr/bin/evince --page-index=%(outpage) %o"))
        (setq TeX-view-program-selection '((output-pdf "Evince")))))))
