#!/bin/bash

pushd dotemacsdotd/tredjeparts/ > /dev/null

pwd

echo "Updating auto-complete"
pushd auto-complete > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating ebnf-mode"
pushd ebnf-mode > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating popup-el"
pushd popup-el > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating emacs-async"
pushd emacs-async > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating yasnippet"
pushd yasnippet > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating wc-mode"
pushd wc-mode > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating emmet-mode"
pushd emmet-mode > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating web-mode"
pushd web-mode > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating helm"
pushd helm > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Updating ensime (emacs-scala-mode)"
pushd emacs-scala-mode > /dev/null
git pull > /dev/null
popd > /dev/null

echo "Source s now updated. Remember to run buildfiles for sources that needs to be built"

popd > /dev/null
