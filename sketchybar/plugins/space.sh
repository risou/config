#!/bin/bash

update() {
  WIDTH="dynamic"
  # if [ "$SELECTED" = "true" ]; then
  #   WIDTH="0"
  # fi

  sketchybar --animate tanh 20 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    # yabai -m space --focus $SID 2>/dev/null
    # SIP on
    CURRENT=$(yabai -m query --spaces --space | jq .index)
    DIFF=$(($SID - $CURRENT))
    if [ $DIFF -gt 0 ]; then
      for ((i=0; i<DIFF; i++)); do
        osascript -e 'tell app "System Events" to key code "124" using control down'
      done
    elif [ $DIFF -lt 0 ]; then
      for ((i=0; i>DIFF; i--)); do
      osascript -e 'tell app "System Events" to key code "123" using control down'
      done
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
