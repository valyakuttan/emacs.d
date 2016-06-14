;; init-flychek.el

(add-hook 'prog-mode-hook #'flycheck-mode)

;; disable ghc for linting we prefer hlint checking
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(haskell-ghc))))

;; disable jshint since we prefer eslint checking
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint))))

;; disable json-jsonlist checking for json files
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(json-jsonlist))))

;; use eslint with web-mode for jsx files
(with-eval-after-load 'flycheck
   (flycheck-add-mode 'javascript-eslint 'web-mode))

;; disable rust-cargo
;;(with-eval-after-load 'flycheck
;;  (setq-default flycheck-disabled-checkers
;;                (append flycheck-disabled-checkers
 ;;                       '(rust-cargo))))
