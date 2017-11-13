function peco-tmux-select-window() {
	tmux list-windows | peco | awk -F':' '{print $1}' | xargs tmux select-window -t
}
zle -N peco-tmux-select-window
