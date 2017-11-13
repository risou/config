# load peco sources
for f (~/.zsh/peco-sources/*) source "${f}"

bindkey '^r' peco-select-history
bindkey '^x;' peco-cdr
bindkey '^x^b' peco-git-recent-branches
bindkey '^xb' peco-git-recent-all-branches
bindkey '^]' peco-src
bindkey '^x^x' peco-insert-selected-git-files
bindkey '^x/' peco-ssh
bindkey '^xk' peco-tmux-select-window
