#!/usr/bin/env bash

set -eu

if [ -d "$HOME/.tmux/resurrect" ]; then
  resurrect_dir="$HOME/.tmux/resurrect"
else
  resurrect_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tmux/resurrect"
fi

last_file="$resurrect_dir/last"

session_count="$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')"
if [ "${session_count:-0}" = "0" ]; then
  rm -f "$last_file"
  exit 0
fi

save_script="$(tmux show-option -gqv @resurrect-save-script-path)"
if [ -n "$save_script" ]; then
  "$save_script" quiet >/dev/null 2>&1
fi
