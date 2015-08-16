setopt prompt_subst

# PATH の設定(Rakudo *)
# PATH=$PATH:/Users/risou/Downloads/rakudo-star-2010.07
# PATH の設定(gist.github)
# PATH=$PATH:/Users/risou/github
# PATH の設定(perl-completion.vim)
# PATH=$PATH:/Users/risou/.vim/bin

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# デフォルトの補完機能を有効
autoload -U compinit
compinit -u

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

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# プロンプトの右端にパスを表示
RPROMPT=$'%{\e[32m%}%/%{\e[m%}${vcs_info_msg_0_}'
# RPROMPT="$vcs_info_msg_0_"

# コマンド履歴機能
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

case "${OSTYPE}" in
	freebsd* | darwin* )
		alias ls='ls -G'
	;;
	linux* )
		alias ls="ls --color"
	;;
esac
alias ll='ls -l'

# percol
#source ~/.zsh/percol.zsh
# peco
source ~/.zsh/peco.zsh

# 色情報
export LSCOLORS=gxfxxxxxcxxxxxxxxxxxxx

# emacsclient
#export EDITOR="emacsclient"
export PATH=/usr/local/bin:$PATH
alias e="emacsclient -nw"
alias emacsd="emacs --daemon"
alias emacsk="emacsclient -e '(kill-emacs)'"

eval "$(plenv init - zsh)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

export TERM=xterm-256color

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# coosy dev
export PGDATA=/usr/local/var/postgres

# grunt
export NODE_PATH='/usr/local/lib/node_modules'
