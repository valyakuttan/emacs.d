;; set-path.el

;;
;; set $PATH and exec-path
;;
(setq home (getenv "HOME"))
(setq ghc-bin (concat home "/ghc/bin"))
(setq cabal-bin (concat home "/.cabal/bin"))
(setq node-bin (concat home "/node_modules/bin"))

;;(add-to-path-and-exec-path
;; ghc-bin
;; cabal-bin
;; node-bin)

;; python virtual environment setup
(setq work-on-home (concat home "/src/venv"))
(setenv "WORKON_HOME" work-on-home)

