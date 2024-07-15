#!/bin/bash

network=(
  icon.font="Hack Nerd Font:Bold:14.0"
  label.drawing=on
  update_freq=60
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network right      \
           --set network "${network[@]}" \
           --subscribe network system_woke

