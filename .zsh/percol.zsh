# load percol sources
for f (~/.zsh/percol-sources/*) source "${f}"

bindkey '^r' percol-select-history
bindkey '^x^b' percol-git-recent-branches
bindkey '^xb' percol-git-recent-all-branches
bindkey '^x;' percol-cd-history
bindkey '^xi' percol-insert-cd-history
bindkey '^xt' percol-tmux-select-pane