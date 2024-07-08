#!/bin/bash

meetingbar=(
  script="$PLUGIN_DIR/meetingbar.sh"
  label.drawing=on
  click_script="osascript ~/.config/simplebar/meetingbar.scpt join"
  update_freq=60
)

sketchybar --add item meetingbar right \
           --set meetingbar "${meetingbar[@]}" \
