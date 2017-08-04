#!/bin/bash

############################################
# Initial setup (written for Ubuntu 15.10) #
############################################

pushd dotemacsdotd/tredjeparts/ > /dev/null

git clone https://github.com/auto-complete/auto-complete

git clone https://github.com/jeramey/ebnf-mode

git clone https://github.com/auto-complete/popup-el

git clone https://github.com/capitaomorte/yasnippet

git clone https://github.com/bnbeckwith/wc-mode

git clone https://github.com/smihica/emmet-mode

git clone https://github.com/fxbois/web-mode

popd > /dev/null
