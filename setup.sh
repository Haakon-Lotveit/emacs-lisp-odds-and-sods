#!/bin/bash

############################################
# Initial setup (written for Ubuntu 16.10) #
############################################

pushd dotemacsdotd/tredjeparts/ > /dev/null

pwd

git clone https://github.com/auto-complete/auto-complete

git clone https://github.com/jeramey/ebnf-mode

git clone https://github.com/auto-complete/popup-el

git clone https://github.com/capitaomorte/yasnippet

git clone https://github.com/bnbeckwith/wc-mode

git clone https://github.com/smihica/emmet-mode

git clone https://github.com/fxbois/web-mode

git clone https://github.com/jwiegley/emacs-async.git

git clone https://github.com/emacs-helm/helm.git

git clone https://github.com/ensime/emacs-scala-mode

popd > /dev/null
