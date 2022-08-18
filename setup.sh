#!/bin/bash


# TODO(gigilibala): Make this Linux vs Mac OS dependent.

ln --symbolic "${HOME}/emacs.d/init.el" "${HOME}/configs/init.el" || true

if ! grep "source \$HOME/configs/bashrc" "${HOME}/.bashrc"; then
  echo "source \$HOME/configs/bashrc" >> "${HOME}/.bashrc"
fi

snap install --classic emacs || true

sudo apt install --yes python3-pip || true

snap install --classic pyright || true
