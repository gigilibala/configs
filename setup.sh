#!/bin/bash

# TODO(gigilibala): Make this Linux vs Mac OS dependent.

mkdir --parent "${HOME}/.emacs.d"
ln -s "${HOME}/configs/init.el" "${HOME}/.emacs.d/init.el" || true

ln -s "${HOME}/configs/tmux.conf" "${HOME}/.tmux.conf" || true

function setup_macos() {
  ln -s "${HOME}/configs/zshrc" "${HOME}/.zshrc" || true
}

function setup_linux() {
  if ! grep "source \$HOME/configs/bashrc" "${HOME}/.bashrc"; then
    echo "source \$HOME/configs/bashrc" >> "${HOME}/.bashrc"
  fi

  snap install --classic emacs || true
  sudo apt install --yes python3-pip || true
  snap install --classic pyright || true
}

UNAME="$(uname -s)"
case "${UNAME}" in
  Linux*)
    setup_linux
    ;;
  Darwin*)
    setup_macos
    ;;
  *)
    echo "Unsupported operating system!"
    exit 1
    ;;
esac
