#!/bin/bash

update() {
    WIDTH="dynamic"
    sketchybar --animate tanh 20 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH
}

mouse_clicked() {
    aerospace workspace ${NAME##*.}
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac

