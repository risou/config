#!/bin/bash

half_yearly_pr_count=(
  icon=$GIT_PULL_REQUEST
  label.drawing=on
  update_freq=3600
  script="$PLUGIN_DIR/half_yearly_pr_count.sh"
)

sketchybar --add item half_yearly_pr_count right \
           --set half_yearly_pr_count "${half_yearly_pr_count[@]}"