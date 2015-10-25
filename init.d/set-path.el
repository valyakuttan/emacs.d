;; set-path.el

(defun add-to-path-and-exec-path (&rest path-entries)
  "add path-entries to both PATH and exec-path, if not present."
  (let* ((new-path (split-string (getenv "PATH") ":"))
         (add-entry (lambda (e)
                      (progn
                        (add-to-list 'new-path e)
                        (add-to-list 'exec-path e)))))
    (if path-entries
        (progn
          (mapc add-entry path-entries)
          (setenv "PATH" (mapconcat 'identity new-path ":"))))))

;;
;; set $PATH and exec-path
;;
(setq home (getenv "HOME"))
(setq ghc-bin (concat home "/ghc/bin"))
(setq cabal-bin (concat home "/.cabal/bin"))
(setq node-bin (concat home "/node_modules/bin"))

(add-to-path-and-exec-path
 ghc-bin
 cabal-bin
 node-bin)
