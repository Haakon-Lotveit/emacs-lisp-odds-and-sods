;; Laster inn mine egne biblioteker

(load-library "småfikser")
(load-library "font-settings")
(load-library "java-mode-snarveier")
(load-library "haskell-mode-settings")
(load-library "python-fikser.el")

;; Legger til Ren'Py mode.
(add-to-list 'load-path "~/.emacs.d/egne/renpy/")
(load-library "renpy-mode")
(require 'renpy-mode)
