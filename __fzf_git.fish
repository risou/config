
function __fzf_git_color
    if test -n "$NO_COLOR"
        echo "never"
    else if test (count $argv) -gt 0 -a -n "$FZF_GIT_PREVIEW_COLOR"
        echo "$FZF_GIT_PREVIEW_COLOR"
    else
        echo "${FZF_GIT_COLOR:-always}"
    end
end

function __fzf_git_cat
    if test -n "$FZF_GIT_CAT"
        echo "$FZF_GIT_CAT"
        return
    end

    # Sometimes bat is installed as batcat
    set _fzf_git_bat_options "--style='${BAT_STYLE:-full}' --color=(__fzf_git_color .) --pager=never"
    
    if type -q batcat
        echo "batcat $_fzf_git_bat_options"
    else if type -q bat
        echo "bat $_fzf_git_bat_options"
    else
        echo cat
    end
end

function __fzf_git_pager
    set pager (echo "$FZF_GIT_PAGER" | string trim)
    
    if test -z "$pager"
        set pager (echo "$GIT_PAGER" | string trim)
    end

    if test -z "$pager"
        set pager (git config --get core.pager ^/dev/null)
    end

    echo "$pager"
    if test -z "$pager"
        echo "cat"
    end
end

if test (count $argv) -eq 1
    function branches
        git branch $argv --sort=-committerdate --sort=-HEAD --format="%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)" --color=(__fzf_git_color) | column -ts"\t"
    end

    function refs
        git for-each-ref $argv --sort=-creatordate --sort=-HEAD --color=(__fzf_git_color) --format="%(if:equals=refs/remotes)%(refname:rstrip=-2)%(then)%(color:magenta)remote-branch%(else)%(if:equals=refs/heads)%(refname:rstrip=-2)%(then)%(color:brightgreen)branch%(else)%(if:equals=refs/tags)%(refname:rstrip=-2)%(then)%(color:brightcyan)tag%(else)%(if:equals=refs/stash)%(refname:rstrip=-2)%(then)%(color:brightred)stash%(else)%(color:white)%(refname:rstrip=-2)%(end)%(end)%(end)%(end)\t%(color:yellow)%(refname:short) %(color:green)(%(creatordate:relative))\t%(color:blue)%(subject)%(color:reset)" | column -ts"\t"
    end

    function hashes
        git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=(__fzf_git_color) $argv
    end

    switch $argv[1]
        case "branches"
            echo "CTRL-O (open in browser) ╱ ALT-A (show all branches)\n"
            branches
        case "all-branches"
            echo "CTRL-O (open in browser)\n"
            branches -a
        case "hashes"
            echo "CTRL-O (open in browser) ╱ CTRL-D (diff)\nCTRL-S (toggle sort) ╱ ALT-A (show all hashes)\n"
            hashes
        case "all-hashes"
            echo "CTRL-O (open in browser) ╱ CTRL-D (diff)\nCTRL-S (toggle sort)\n"
            hashes --all
        case "refs"
            echo "CTRL-O (open in browser) ╱ ALT-E (examine in editor) ╱ ALT-A (show all refs)\n"
            refs --exclude='refs/remotes'
        case "all-refs"
            echo "CTRL-O (open in browser) ╱ ALT-E (examine in editor)\n"
            refs
        case "nobeep"
            # Do nothing
        case '*'
            exit 1
    end

else if test (count $argv) -gt 1
    set -e

    set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test $branch = "HEAD"
        set branch (git describe --exact-match --tags 2>/dev/null || git rev-parse --short HEAD)
    end

    switch $argv[1]
        case "commit"
            set hash (string match -r "[a-f0-9]{7,}" $argv[2])
            set path "/commit/$hash"
        case "branch" "remote-branch"
            set branch (echo $argv[2] | sed 's/^[* ]*//' | cut -d' ' -f1)
            set remote (git config branch."$branch".remote ^/dev/null; or echo "origin")
            set branch (string replace -r "$remote/" "" $branch)
            set path "/tree/$branch"
        case "remote"
            set remote $argv[2]
            set path "/tree/$branch"
        case "file"
            set path "/blob/$branch/(git rev-parse --show-prefix)$argv[2]"
        case "tag"
            set path "/releases/tag/$argv[2]"
        case '*'
            exit 1
    end

    set remote (git config branch."$branch".remote ^/dev/null; or echo "origin")
    set remote_url (git remote get-url "$remote" 2>/dev/null; or echo "$remote")

    if string match -q -r "^git@" $remote_url
        set url (string replace -r ".git$" "" $remote_url)
        set url (string replace -r "^git@" "" $url)
        set url "https://"(string replace -r ":" "/" $url)
    else if string match -q -r "^http" $remote_url
        set url (string replace -r ".git$" "" $remote_url)
    end

    switch (uname -s)
        case "Darwin"
            open "$url$path"
        case '*'
            xdg-open "$url$path"
    end
    exit 0
end

if status --is-interactive
    # -----------------------------------------------------------------------------

    # Redefine this function to change the options
    function _fzf_git_fzf
        fzf --height=50% --tmux 90%,70% \
            --layout=reverse --multi --min-height=20 --border \
            --border-label-pos=2 \
            --color='header:italic:underline,label:blue' \
            --preview-window='right,50%,border-left' \
            --bind='ctrl-/:change-preview-window(down,50%,border-top|hidden|)' $argv
    end

    function _fzf_git_check
        git rev-parse HEAD > /dev/null 2>&1; or return 1

        if set -q TMUX
            tmux display-message "Not in a git repository"
        end
        return 1
    end

    set -l __fzf_git (status filename)
    set __fzf_git (readlink -f "$__fzf_git" 2>/dev/null || /usr/bin/ruby --disable-gems -e 'puts File.expand_path(ARGV.first)' "$__fzf_git" 2> /dev/null)

    function _fzf_git_files
        _fzf_git_check; or return
        set -l root (git rev-parse --show-toplevel)
        set -l query
        if test "$root" != "$PWD"
            set query '!../ '
        end

        (git -c color.status=(__fzf_git_color) status --short --no-branch;
        git ls-files "$root" | grep -vxFf (git status -s | grep '^[^?]' | cut -c4-; echo :) | sed 's/^/   /') |
        _fzf_git_fzf -m --ansi --nth 2..,.. \
            --border-label '📁 Files' \
            --header 'CTRL-O (open in browser) ╱ ALT-E (open in editor)\n\n' \
            --bind "ctrl-o:execute-silent:fish $__fzf_git file {-1}" \
            --bind "alt-e:execute:${EDITOR:-vim} {-1} > /dev/tty" \
            --query "$query" \
            --preview "git diff --no-ext-diff --color=(__fzf_git_color .) -- {-1} | $(__fzf_git_pager); $(__fzf_git_cat) {-1}" $argv |
        cut -c4- | sed 's/.* -> //'
    end

    function _fzf_git_branches
        _fzf_git_check; or return
        fish $__fzf_git branches |
        _fzf_git_fzf --ansi \
            --border-label '🌲 Branches' \
            --header-lines 2 \
            --tiebreak begin \
            --preview-window down,border-top,40% \
            --color hl:underline,hl+:underline \
            --no-hscroll \
            --bind 'ctrl-/:change-preview-window(down,70%|hidden|)' \
            --bind "ctrl-o:execute-silent:fish $__fzf_git branch {}" \
            --bind "alt-a:change-border-label(🌳 All branches)+reload:fish \"$__fzf_git\" all-branches" \
            --preview "git log --oneline --graph --date=short --color=(__fzf_git_color .) --pretty='format:%C(auto)%cd %h%d %s' (echo {} | sed 's/^..//' | cut -d' ' -f1) --" $argv |
        sed 's/^..//' | cut -d' ' -f1
    end

    function _fzf_git_tags
        _fzf_git_check; or return
        git tag --sort -version:refname |
        _fzf_git_fzf --preview-window right,70% \
            --border-label '📛 Tags' \
            --header 'CTRL-O (open in browser)\n\n' \
            --bind "ctrl-o:execute-silent:fish $__fzf_git tag {}" \
            --preview "git show --color=(__fzf_git_color .) {} | $(__fzf_git_pager)" $argv
    end

    function _fzf_git_hashes
        _fzf_git_check; or return
        fish $__fzf_git hashes |
        _fzf_git_fzf --ansi --no-sort --bind 'ctrl-s:toggle-sort' \
            --border-label '🍡 Hashes' \
            --header-lines 3 \
            --bind "ctrl-o:execute-silent:fish $__fzf_git commit {}" \
            --bind "ctrl-d:execute:grep -o '[a-f0-9]{7,}' <<< {} | head -n 1 | xargs git diff --color=(__fzf_git_color) > /dev/tty" \
            --bind "alt-a:change-border-label(🍇 All hashes)+reload:fish \"$__fzf_git\" all-hashes" \
            --color hl:underline,hl+:underline \
            --preview "grep -o '[a-f0-9]{7,}' <<< {} | head -n 1 | xargs git show --color=(__fzf_git_color .) | $(__fzf_git_pager)" $argv |
        awk 'match($0, /[a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]*/) { print substr($0, RSTART, RLENGTH) }'
    end

    function _fzf_git_remotes
        _fzf_git_check; or return
        git remote -v | awk '{print $1 "\t" $2}' | uniq |
        _fzf_git_fzf --tac \
            --border-label '📡 Remotes' \
            --header 'CTRL-O (open in browser)\n\n' \
            --bind "ctrl-o:execute-silent:fish $__fzf_git remote {1}" \
            --preview-window right,70% \
            --preview "git log --oneline --graph --date=short --color=(__fzf_git_color .) --pretty='format:%C(auto)%cd %h%d %s' '{1}/(git rev-parse --abbrev-ref HEAD)' --" $argv |
        cut -d'\t' -f1
    end

    function _fzf_git_stashes
        _fzf_git_check; or return
        git stash list | _fzf_git_fzf \
            --border-label '🥡 Stashes' \
            --header 'CTRL-X (drop stash)\n\n' \
            --bind 'ctrl-x:reload(git stash drop -q {1}; git stash list)' \
            -d: --preview "git show --color=(__fzf_git_color .) {1} | $(__fzf_git_pager)" $argv |
        cut -d: -f1
    end

    function _fzf_git_lreflogs
        _fzf_git_check; or return
        git reflog --color=(__fzf_git_color) --format="%C(blue)%gD %C(yellow)%h%C(auto)%d %gs" | _fzf_git_fzf --ansi \
            --border-label '📒 Reflogs' \
            --preview "git show --color=(__fzf_git_color .) {1} | $(__fzf_git_pager)" $argv |
        awk '{print $1}'
    end

    function _fzf_git_each_ref
        _fzf_git_check; or return
        fish $__fzf_git refs | _fzf_git_fzf --ansi \
            --nth 2,2.. \
            --tiebreak begin \
            --border-label '☘️  Each ref' \
            --header-lines 2 \
            --preview-window down,border-top,40% \
            --color hl:underline,hl+:underline \
            --no-hscroll \
            --bind 'ctrl-/:change-preview-window(down,70%|hidden|)' \
            --bind "ctrl-o:execute-silent:fish $__fzf_git {1} {2}" \
            --bind "alt-e:execute:${EDITOR:-vim} <(git show {2}) > /dev/tty" \
            --bind "alt-a:change-border-label(🍀 Every ref)+reload:fish \"$__fzf_git\" all-refs" \
            --preview "git log --oneline --graph --date=short --color=(__fzf_git_color .) --pretty='format:%C(auto)%cd %h%d %s' {2} --" $argv |
        awk '{print $2}'
    end

    function _fzf_git_worktrees
        _fzf_git_check; or return
        git worktree list | _fzf_git_fzf \
            --border-label '🌴 Worktrees' \
            --header 'CTRL-X (remove worktree)\n\n' \
            --bind 'ctrl-x:reload(git worktree remove {1} > /dev/null; git worktree list)' \
            --preview "
                git -c color.status=(__fzf_git_color .) -C {1} status --short --branch
                echo
                git log --oneline --graph --date=short --color=(__fzf_git_color .) --pretty='format:%C(auto)%cd %h%d %s' {2} --
            " $argv |
        awk '{print $1}'
    end

    function __fzf_git_init
        # No binding mechanism like bash or zsh for fish, leave it as a noop
    end

    __fzf_git_init files branches tags remotes hashes stashes lreflogs each_ref worktrees

    # -----------------------------------------------------------------------------
end

