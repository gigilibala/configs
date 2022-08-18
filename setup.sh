#!/bin/bash


# TODO(gigilibala): Make this Linux vs Mac OS dependent.

mkdir --parent "${HOME}/.emacs.d"
ln --symbolic "${HOME}/configs/init.el" "${HOME}/emacs.d/init.el" || true

ln --symbolic "${HOME}/configs/tmux.conf" "${HOME}/.tmux.conf" || true

if ! grep "source \$HOME/configs/bashrc" "${HOME}/.bashrc"; then
  echo "source \$HOME/configs/bashrc" >> "${HOME}/.bashrc"
fi

snap install --classic emacs || true

sudo apt install --yes python3-pip || true

snap install --classic pyright || true
