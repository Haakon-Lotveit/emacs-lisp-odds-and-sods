;;Cleaned up init.el file for Haakon Løtveit, March 2012

(require 'cl)
(global-linum-mode 1)

;; Different stuff I've written myself
(add-to-list 'load-path "~/.emacs.d/egne")
(load-library "init-egne")

;; Stuff other people have written that I've loaded.
;; Also, libraries that are not installed via the package manager
(add-to-list 'load-path "~/.emacs.d/tredjeparts")
(load-library "init-3rdparty")

(setq inhibit-splash-screen 't)
;(server-start)

;; Removes the *ESS* buffer after startup.
(if (get-buffer "*ESS*") (kill-buffer "*ESS*"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(haskell-program-name "ghci"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
