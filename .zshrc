setopt prompt_subst

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

# zsh powerline
#export PATH=$PATH:~/Library/Python/2.7/bin
#powerline-daemon -q
#. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

# プロンプトの右端にパスを表示
PROMPT=$'[%{${fg[cyan]}%}%n%{${reset_color}%}@%{${bg[blue]}%}%m%{${reset_color}%}] %# '
RPROMPT=$'%{\e[32m%}%~%{\e[m%}${vcs_info_msg_0_}[%D %*]'
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
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
alias e="emacsclient -nw"
alias emacsd="emacs --daemon"
alias emacsk="emacsclient -e '(kill-emacs)'"

# eval "$(plenv init - zsh)"
# export PATH="$HOME/.phpenv/bin:$HOME/.phpenv/shims:$PATH"
# eval "$(phpenv init - zsh)"
# export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
# eval "$(rbenv init - zsh)"

# PHPENV <-> Apache2 連携用
# export PHPENV_APACHE_MODULE_PATH="$HOME/.phpenv"

export TERM=xterm-256color

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# coosy dev
export PGDATA=/usr/local/var/postgres

# tmux mouse
function tmux-mouse-on {
	if [ -z $TMUX ]; then
		return
	fi
	tmux set-option -w mouse on > /dev/null
}
function tmux-mouse-off {
	if [ -z $TMUX ]; then
		return
	fi
	tmux set-option -w mouse off > /dev/null
}
tmuxOffCmds=("man" "less" "vi" "vim" "emacs")
function preexec_for_tmux {
	command=`echo "$1" | cut -f 1 -d " "`
	for cmd in $tmuxOffCmds; do
		if [ "$cmd" = "$command" ]; then
			tmux-mouse-off
			export SHOULD_TMUX_ON=t
		fi
	done
}
function precmd_for_tmux {
	if [ -n $SHOULD_TMUX_ON ]; then
		tmux-mouse-on
		unset SHOULD_TMUX_ON
	fi
}
preexec_functions=($preexec_functions preexec_for_tmux)
precmd_functions=($precmd_functions precmd_for_tmux)

# coosy dev
export PGDATA=/usr/local/var/postgres

# grunt
export NODE_PATH='/usr/local/lib/node_modules'

# ghq
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# Visual Studio Code
code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# javac encoding
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

export PATH=$PATH:$HOME/.zsh/bin

