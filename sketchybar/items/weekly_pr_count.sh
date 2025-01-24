#!/bin/bash

weekly_pr_count=(
  icon=$GIT_PULL_REQUEST
  label.drawing=on
  update_freq=600
  script="$PLUGIN_DIR/weekly_pr_count.sh"
)

pr_count_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
)

sketchybar --add item weekly_pr_count right \
           --set weekly_pr_count "${weekly_pr_count[@]}"

sketchybar --add bracket pr_count weekly_pr_count half_yearly_pr_count \
           --set pr_count "${pr_count_bracket[@]}"
