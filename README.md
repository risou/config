環境構築
====

# Vim

```sh
$ ln -s $(pwd)/.vimrc $HOME/.vimrc
$ ln -s $(pwd)/../dotvim $HOME/.vim
$ cd ../dotvim
$ git submodule update --init
```

# tmux

```sh
$ brew install tmux
$ ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
$ ln -s $(pwd)/.tmux-powerlinerc $HOME/.tmux-powerlinerc
```

TODO: tmux-powerline

# zsh

```sh
$ brew install zsh
$ ln -s $(pwd)/.zshrc $HOME/.zshrc
$ ln -s $(pwd)/.zsh $HOME/.zsh
A
```

# peco

TODO: peco
