#!/bin/bash

network=(
  label.drawing=on
  update_freq=300
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network right      \
           --set network "${network[@]}" \
           --subscribe network system_woke

