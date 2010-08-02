# PATH の設定(Rakudo *)
PATH=$PATH:/Usr/risou/Downloads/rakudo-star-2010.07

# デフォルトの補完機能を有効
autoload -U compinit
compinit

# プロンプトのカラー表示を有効
autoload -U colors
colors

# プロンプトの右端にパスを表示
RPROMPT=$'%{\e[32m%}%/%{\e[m%}'

# コマンド履歴機能
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

alias ls='ls -G'
alias ll='ls -l'

# MacPorts 用
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH

# 色情報
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx
