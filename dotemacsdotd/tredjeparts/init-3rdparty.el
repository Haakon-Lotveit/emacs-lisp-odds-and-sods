;;slime stuff
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")

;;Adds nxhtml
(add-to-list 'load-path "~/emacs-lisp-odds-and-sods/dotemacsdotd/tredjeparts/nxhtml")
(load-library "autoload")

;; Adds yasnippet
(add-to-list 'load-path "~/emacs-lisp-odds-and-sods/dotemacsdotd/tredjeparts/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; Adds auto-completion support
(add-to-list 'load-path "~/emacs-lisp-odds-and-sods/dotemacsdotd/tredjeparts/auto-complete")
(add-to-list 'load-path "~/emacs-lisp-odds-and-sods/dotemacsdotd/tredjeparts/popup-el/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs-lisp-odds-and-sods/dotemacsdotd/ac-dict")
(ac-config-default)

;; Adds wc-mode
(add-to-list 'load-path "~/emacs-lisp-odds-and-sods/dotemacsdotd/tredjeparts/wc-mode/")
(load "wc-mode")
;; Adds jdee, built using the script in oppdateringsskript/jdee.sh
;(add-to-list 'load-path "/usr/local/jdee/lisp")
;(load "jde")

;; Adds zencoding minor mode
(add-to-list 'load-path "~/emacs-lisp-odds-and-sods/dotemacsdotd/tredjeparts/zencoding")
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
