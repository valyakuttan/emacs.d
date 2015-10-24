;; set-path.el

;;
;; set $PATH and exec-path
;;
(setq home (getenv "HOME"))
(setq ghc-bin (concat home "/ghc/bin"))
(setq cabal-bin (concat home "/.cabal/bin"))
(setq node-bin (concat home "/node_modules/bin"))

(setq new-path (split-string (getenv "PATH") ":"))
(add-to-list 'new-path ghc-bin)
(add-to-list 'new-path cabal-bin)
(add-to-list 'new-path node-bin)

(setenv "PATH" (mapconcat 'identity new-path ":"))

(add-to-list 'exec-path ghc-bin)
(add-to-list 'exec-path cabal-bin)
(add-to-list 'exec-path node-bin)
