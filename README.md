環境構築
====

# Vim

```sh
$ ln -s $(pwd)/.vimrc $HOME/.vimrc
$ ln -s $(pwd)/../dotvim $HOME/.vim
$ cd ../dotvim
$ git submodule update --init
```

# zsh

```sh
$ brew install zsh
$ ln -s $(pwd)/.zshrc $HOME/.zshrc
$ ln -s $(pwd)/.zsh $HOME/.zsh
A
```

# go & ghq

```sh
$ brew install go
$ brew install ghq
$ git config --global ghq.root $HOME/src
```

他、適宜必要にあわせて `$HOME/src/github.com/risou/config/gitconfig_base` から取得。

# peco

```sh
$ brew install peco
$ ln -s $(pwd)/.peco $HOME/.peco
```

# powerline

この項目の内容は最適化できていないので、そのまま参照しないこと。

```sh
$ brew install python
$ vim $HOME/.pydistutils.cfg
    # 以下の2行を記述
    # [install]
    # prefix=
$ pip install --user powerline-status
```

powerline font の取得

```sh
$ git clone git@github.com:powerline/fonts.git # ghq get でも良い
```

# tmux

```sh
$ brew install tmux
$ ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
$ ln -s $(pwd)/.tmux-powerlinerc $HOME/.tmux-powerlinerc
$ ghq get https://github.com/erikw/tmux-powerline
$ ln -s $GOPATH/src/github.com/erikw/tmux-powerline $HOME/.tmux/tmux-powerline
$ ln -s $(pwd)/origtheme.sh $HOME/src/github.com/erikw/tmux-powerline/themes/origtheme.sh
$ vim $HOME/src/github.com/erikw/tmux-powerline/segments/vcs_branch.sh # change git_colour from "5" to "253"
```

# rbenv

```sh
$ brew install rbenv ruby-build
$ vim $HOME/.zshrc
    # 以下2行のコメントを外す
    # export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
    # eval "$(rbenv init - zsh)"
$ source $HOME/.zshrc
```

# phpenv

このインストール方法では上手くいかない。

明日確認して修正する。

```sh
$ breww tap josegonzalez/homebrew-php
$ brew install phpenv
$ brew install --HEAD php-build
$ vim $HOME/.zshrc
    # 以下2行のコメントを外す
    # export PATH="$HOME/.phpenv/bin:$HOME/.phpenv/shims:$PATH
    # eval "$(phpenv init - zsh)"
$ source $HOME/.zshrc
```
