function peco-select-from-git-status() {
	git status --porcelain | \
	peco | \
	awk -F ' ' '{print $NF}' | \
	tr '\n' ' '
}

function peco-insert-selected-git-files() {
	LBUFFER+=$(peco-select-from-git-status)
	CURSOR=$#LBUFFER
	zle reset-prompt
}

zle -N peco-insert-selected-git-files
