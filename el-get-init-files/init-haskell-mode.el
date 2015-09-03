;; init-haskell-mode.el

(require 'with-eval-after-load-feature)
(require 'haskell-mode-autoloads)

;; part of haskell-interactive-mode setup
(require 'haskell-interactive-mode)
(require 'haskell-process)

;; enable stylish-haskell
;;(custom-set-variables
;; '(haskell-stylish-on-save t))

;; some handy features of haskell interactive mode.
(custom-set-variables
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))

;; set ghci process type to cabal-repl
(custom-set-variables
 '(haskell-process-type 'cabal-repl)
 '(haskell-process-args-cabal-repl '("--ghc-option=-ferror-spans")))

;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; enable module templates
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

;; haskell-mode bindings
(define-key haskell-mode-map [f8] 'haskell-navigate-imports)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
(define-key haskell-mode-map (kbd "C-c C-l")
  'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c")
  'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k")
  'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

;; haskell-cabal-mode bindings
(with-eval-after-load-feature 'haskell-cabal
  (progn
    (define-key haskell-cabal-mode-map (kbd "C-`")
      'haskell-interactive-bring)
    (define-key haskell-cabal-mode-map (kbd "C-c C-z")
      'haskell-interactive-switch)
    (define-key haskell-cabal-mode-map (kbd "C-c C-k")
      'haskell-interactive-mode-clear)
    (define-key haskell-cabal-mode-map (kbd "C-c C-c")
      'haskell-process-cabal-build)
    (define-key haskell-cabal-mode-map (kbd "C-c c")
      'haskell-process-cabal)))
