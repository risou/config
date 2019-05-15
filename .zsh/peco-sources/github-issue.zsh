function peco-github-select-issue() {
    local issues=$(hub issue 2> /dev/null)
    if [ -z "$issues" ]; then
        echo "issue not found." 1>&2
        return
    fi
    local number=$(echo "$issues" | peco --query "$LBUFFER" | sed 's/^[^0-9]*\([0-9]*\).*$/\1/1')
    if [ -z "$number" ]; then
        return
    fi
    hub browse -- "issues/$number"
}
zle -N peco-github-select-issue

function peco-github-select-pr() {
    local pr=$(hub pr list 2> /dev/null | peco --query "$LBUFFER" | sed -e 's/^[^0-9]*\([0-9]*\).*$/\1/1')
    if [ -n "$pr" ]; then
        BUFFER="hub browse -- \"pull/${pr}\""
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-github-select-pr
