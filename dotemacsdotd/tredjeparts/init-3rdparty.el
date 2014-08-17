
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

;; Extended Backus-Naur Form mode
;; From https://github.com/jeramey/ebnf-mode
(add-to-list 'load-path "~/.emacs.d/tredjeparts/ebnf-mode")
(load "ebnf-mode")

;; CSV-mode
;; From http://www.emacswiki.org/emacs/download/csv-mode.el
(add-to-list 'load-path "~/.emacs.d/tredjeparts/csv-mode")
(load "csv-mode")
 

;; Adds jdee, built using the script in oppdateringsskript/jdee.sh
;(add-to-list 'load-path "/usr/local/jdee/lisp")
;(load "jde")

