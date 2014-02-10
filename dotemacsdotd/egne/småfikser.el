;; Fra Steve Yegge's effective emacs
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Egne småting
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-x\C-o" 'other-window)
(setq x-select-enable-clipboard 't)
(setq visible-bell 1)
(transient-mark-mode 1) ; just in case someone turns this off somewhere before init.el is loaded
(show-paren-mode 1)
(require 'iso-transl) ; Fixes dead keys.

;; Legg til repoer til ELPA
(defvar package-archives ()) ; Aner ikke hvorfor denne trengs
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Aliaser
(defalias 'rs 'replace-string)
(defalias 'rre 'replace-regexp)
