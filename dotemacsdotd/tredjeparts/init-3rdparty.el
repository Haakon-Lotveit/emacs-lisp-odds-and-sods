
;;slime stuff
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")

;;Adds nxhtml
(add-to-list 'load-path "~/.emacs.d/tredjeparts/nxhtml")
(load-library "autoload")

;; Adds yasnippet
(add-to-list 'load-path "~/.emacs.d/tredjeparts/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Adds auto-completion support
(add-to-list 'load-path "~/.emacs.d/tredjeparts/auto-complete")
(add-to-list 'load-path "~/.emacs.d/tredjeparts/popup-el/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; Adds jdee, built using the script in oppdateringsskript/jdee.sh
(add-to-list 'load-path "/usr/local/jdee/lisp")
(load "jde")

