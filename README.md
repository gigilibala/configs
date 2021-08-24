# Amin's Developing Configs

These are some of my editor config files. Feel free to use them.

## Emacs

To setup the emacs `init.el` file:

```bash
$ mkdir $HOME/.emacs.d
$ ln -s $HOME/configs/init.el $HOME/.emacs.d/init.el
```

The first time starting emacs, it will fail as you need to install
[`use-package`](https://github.com/jwiegley/use-package) package first (probably
through `package-list-packages`). Then try to load emacs again.

## Bash Profile

```bash
$ cat >> ~/.bashrc
. $HOME/configs/bashrc
^C
```

## Tmux

```bash
$ ln -s $HOME/configs/tmux.conf $HOME/.tmux.conf
```
