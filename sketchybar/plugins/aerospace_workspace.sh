#!/bin/bash

update() {
    WIDTH="dynamic"
    sketchybar --animate tanh 20 --set $NAME icon.highlight=$SELECTED label.width=$WIDTH
}

case "$SENDER" in
  *) update
  ;;
esac

