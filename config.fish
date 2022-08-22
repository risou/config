set -x GOPATH /Users/risou
set -x PATH /usr/local/bin $PATH
set -x PATH $PATH $GOPATH/bin
set -x PATH $PATH $HOME/go/bin
set -x PATH $PATH /usr/local/Cellar/rakudo-star/2021.04/share/perl6/site/bin
set -x PATH $PATH $HOME/.cargo/bin

set -x PATH $PATH /usr/local/Cellar/python@3.9/3.9.6/Frameworks/Python.framework/Versions/3.9/bin

set -x LANG ja_JP.UTF-8

set -x FZF_DEFAULT_OPTS '--reverse --bind=ctrl-j:accept,ctrl-k:kill-line,ctrl-space:toggle-down'
set -x FZF_TMUX 1

set -x GPG_TTY (tty)

set -x fish_color_search_match --background='#4169e1'

# deny overwrite "ctrl+f" by fig.io
set -x FIG_WORKFLOWS_KEYBIND "^\\"

set fish_greeting "..."

alias e="emacsclient -nw"
alias emacsd="emacs --daemon"
alias emacsk="emacsclient -e '(kill-emacs)'"

set -x PATH $PATH $HOME/.anyenv/bin
anyenv init - fish | source

bind \cs __fzf_find_file
bind \c] __ghq_repository_search
bind -e \cg
bind \cx/ 'ag --ignore-case \'^host [^*]\' ~/.ssh/config | cut -d \' \' -f 2 | fzf-tmux | read -l result; and commandline "ssh $result"; and commandline -f execute'
bind \cx\cb 'git branch | grep -v HEAD | sed -e \'s/* /  /g\' | string trim | fzf-tmux | read -l result; and commandline "git checkout $result"; and commandline -f execute'
bind \cxb 'git branch --all | grep -v HEAD | sed -e \'s/* /  /g\' | string trim | fzf-tmux | read -l result; and commandline "git checkout -t $result"; and commandline -f execute'
bind \cx\cx fzf-select-from-git-status
bind \cx\co github-open-current-issue
bind \cxo fzf-github-open-issue
# bind \cxp open-pr-from-commit
bind \cxz 'cat ~/.zsh_history | fzf-tmux | read -l result; and commandline "$result"'

function fzf-select-from-git-status
  set -l list (git status --porcelain | fzf-tmux -m | awk -F ' ' '{print $NF}' | tr '\n' ' ')
  [ -n "$list" ]; and commandline -i $list
end

function github-open-current-issue
  set -l prefix "hub view -- 'issues/"
  set -l suffix "'"
  set -l cursor (commandline -C)
  commandline -C 0
  commandline -i $prefix
  commandline -a $suffix
  commandline -C (math $cursor + (string length $prefix))
end

function fzf-github-open-issue
  set -l buffer (commandline)
  set -l repo (ghq list | peco --query "$buffer" | sed -e 's/^.*\/\([^/]*\)\/\([^/]*\)$/\1\/\2/1')
  set -l prefix "hub view $repo 'issues/"
  set -l suffix "'"
  commandline -r $prefix
  commandline -a $suffix
  commandline -C (string length $prefix)
end

function graph
    # git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv | fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    git log --graph --color=always --format="%C(red)%h%C(reset) %C(yellow)%d%C(reset) %s %C(green)(%ad)%C(reset) %C(bold blue)<%an>%C(reset)" --abbrev-commit --date=iso $argv | fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute(grep -o '[a-f0-9]\{7,\}' | head -1 | xargs -I % git show --color=always % | less -R)"
end

function open-pr-from-commit
  set -l default_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  hub browse -- (git log --merges --oneline --reverse --ancestry-path $argv..."$default_branch" | grep 'Merge pull request #' | head -n 1 | cut -f5 -d' ' | sed -e 's%#%pull/%')
end

# original: decors/fish-ghq
function __ghq_repository_search -d 'Repository search'
  set -l selector_options
  [ -n "$GHQ_SELECTOR_OPTS" ]; and set selector_options $GHQ_SELECTOR_OPTS

  set -l query (commandline -b)
  [ -n "$query" ]; and set flags --query="$query"; or set flags
  ghq list --full-path | eval "fzf-tmux" $selector_options $flags | read select
  [ -n "$select" ]; and commandline "cd $select"; and commandline -f execute
  commandline -f repaint
end

if test -z (echo $TMUX)
  function tmux
    if test (count $argv) -eq 0; and tmux has-session 2>/dev/null
      command tmux attach-session
    else if test (count $argv) -ne 0
      command tmux $argv
    else
      command tmux new-session
    end
  end
end

function ssh
  if test -n (echo $TMUX)
#    tmux select-pane -P 'bg=colour17'
    command ssh $argv
#    tmux select-pane -P 'default'
  else
    command ssh $argv
  end
end
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

starship init fish | source
eval (direnv hook fish)
