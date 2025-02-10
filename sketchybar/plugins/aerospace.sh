#!/bin/bash

aerospace_workspace_change () {
  source "$HOME/.config/sketchybar/colors.sh"
  source "$HOME/.config/sketchybar/icons.sh"

  args=()
  args+=(--set $NAME label.drawing=off)
  args+=(--set $NAME icon=$YABAI_GRID icon.color=$ORANGE)

  MONITORS="$(aerospace list-monitors --json | jq -r '.[]."monitor-id"')"

  for monitor in $MONITORS
  do
    CURRENT_SPACES="$(aerospace list-workspaces --monitor $monitor)"
    current=$(aerospace list-workspaces --monitor $monitor --visible)
    
    for space in $CURRENT_SPACES
    do
      icon_strip=" "
      apps=$(aerospace list-windows --workspace $space --json | jq -r '.[]."app-name"')
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          icon_strip+=" $($HOME/.config/sketchybar/plugins/icon_map.sh "$app")"
        done <<< "$apps"
      fi
      if [ "$icon_strip" != " " ]; then
        args+=(--set space.$space label="$icon_strip" label.drawing=on)
      else
        args+=(--set space.$space label.drawing=off)
      fi
      if [ "$current" == "$space" ]; then
        args+=(--set space.$space icon.color=$RED)
      else
        args+=(--set space.$space icon.color=$WHITE)
      fi
    done
  done

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  # yabai -m window --toggle float
  aerospace_workspace_change
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "aerospace_workspace_change") aerospace_workspace_change
  ;;
  "forced" ) aerospace_workspace_change
  ;;
esac

