2022/08~ 新PC移行に伴い後々アップデートする

環境構築
====

# Vim

```sh
$ ln -s $(pwd)/.vimrc $HOME/.vimrc
$ ln -s $(pwd)/../dotvim $HOME/.vim
$ cd ../dotvim
$ git submodule update --init
```

# Emacs

2020/10~

```sh
$ brew cask install emacs
$ ln -s $(pwd)/init.el $HOME/.emacs.d/init.el
```

~2020/09

```sh
$ brew install --gnutls --japanese emacs
$ ln -sfv /usr/local/opt/emacs/*.plist ~/Library/LaunchAgents
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.emacs.plist # out of tmux
$ mkdir ~/.emacs.d
$ mkdir ~/.emacs.d/elisp
$ mkdir ~/.emacs.d/conf
$ mkdir ~/.emacs.d/public_repos
$ ln -s $(pwd)/init.el $HOME/.emacs.d/init.el
```

`C-;` で `helm-mini` を呼び出したいので、 iTerm2 の Profiles -> Keys で以下を設定。

```
^; Send Hex Codes: 0x18 0x40 0x63 0x3b
```

Use Spacemacs

- install https://github.com/syl20bnr/spacemacs

```sh
$ ln -s $(pwd).spacemacs $HOME/.spacemacs
```

install cmigemo for emacs

```sh
$ brew install cmigemo
```

# zsh


```sh
$ brew install zsh
$ ln -s $(pwd)/.zshrc $HOME/.zshrc
$ ln -s $(pwd)/.zsh $HOME/.zsh

$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
# $ brew install zplug
```

# fish & fzf

scrapbox に書いた。

https://scrapbox.io/risou/fish%2Ffzf_%E3%81%B8%E3%81%AE%E7%A7%BB%E8%A1%8C

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

今後は powerline/powerline を使っていくのが正しそう。
https://qiita.com/tkhr/items/8cc17c02dea1803be9c6

```sh
$ ln -s $(pwd)/powerline $HOME/.config/powerline
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

OS X と tmux のクリップボードを共有するため以下をインストール

```sh
$ brew install reattach-to-user-namespace
```

# gnupg

```sh
$ brew install gnupg pinentry-mac
$ ln -s $(pwd)/gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
$ git config --global user.signingkey <public key>
```

# alacritty

```sh
$ brew cask install alacritty
```

https://github.com/jwilm/alacritty
https://github.com/jwilm/alacritty/blob/master/INSTALL.md

# anyenv

see: https://github.com/riywo/anyenv

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

```sh
$ brew install homebrew/php
$ brew install phpenv
$ git clone https://github.com/CHH/php-build ~/.phpenv/plugins/php-build
$ cp ~/.phpenv/plugins/php-build/bin/phpenv-install ~/.phpenv/plugins/php-build/bin/rbenv-install
$ sed -i -e "s/# Provide phpenv completions/# Provide rbenv completions/g" ~/.rbenv/plugins/php-build/bin/rbenv-install
$ brew install re2c
$ brew install jpeg
$ brew install mcrypt
$ brew install libpng
$ brew install libtool
$ brew install openssl
$ brew install libxml2
$ vim ~/.phpenv/plugins/php-build/share/php-build/default_configure_options
    # --without-pear -> --with-pear
    # --with-apxs2=/usr/sbin/apxs # 追加
$ phpenv install 5.6.*
```

openssl関連でlinkエラーになる場合などは以下を試してみる。

```sh
$ brew doctor
    # brew doctorの結果必要であれば以下も
$ brew unlink openssl
$ brew unlink libxml2
```

## phpenv-apache-version

以下 Mac にデフォルトで入っている Apache を使う場合。

```sh
$ git clone https://github.com/garamon/phpenv-apache-version ~/.phpenv/plugins/phpenv-apache-version
$ cp -p ~/.phpenv/versions/{version}/libexec/apache2/libphp5.so ~/.phpenv/versions/{version}/
    # .zshrc で export PHPENV_APACHE_MODULE_PATH がコメントアウトされていたら外す
$ vim /etc/apache2/httpd.conf
    # LoadModule php5_module $HOME/.phpenv <- フルパスで記述
$ phpenv apache-version {version}
```

## global

```sh
$ ln -s $(pwd)/.globalrc $HOME/.globalrc
```

## ranger

```sh
$ brew install ranger w3m lynx highlight atool mediainfo xpdf libcaca imlib2
$
$ ln -s $(pwd)/ranger/rc.conf $HOME/.config/ranger/rc.conf
$ ln -s $(pwd)/ranger/rifle.conf $HOME/.config/ranger/rifle.conf
$ ln -s $(pwd)/ranger/scope.conf $HOME/.config/ranger/scope.conf
```

## ag

```sh
$ brew install ag
```
