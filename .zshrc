setopt prompt_subst

# PATH の設定(Rakudo *)
# PATH=$PATH:/Users/risou/Downloads/rakudo-star-2010.07
# PATH の設定(gist.github)
# PATH=$PATH:/Users/risou/github
# PATH の設定(perl-completion.vim)
# PATH=$PATH:/Users/risou/.vim/bin

# デフォルトの補完機能を有効
autoload -U compinit
compinit

# プロンプトのカラー表示を有効
autoload -U colors
colors

# Git との連携
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:*' actionformats ' %F{1}(%b%u%c:%a)%f'
zstyle ':vcs_info:*' formats ' %F{2}(%b%u%c)%f'
precmd () { vcs_info }

# プロンプトの右端にパスを表示
RPROMPT=$'%{\e[32m%}%/%{\e[m%}${vcs_info_msg_0_}'
# RPROMPT="$vcs_info_msg_0_"

# コマンド履歴機能
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

alias ls='ls -G'
alias ll='ls -l'

# 色情報
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx

# emacsclient
export EDITOR="emacsclient"
