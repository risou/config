#!/bin/bash

DEVICE=$(route get default | grep interface | awk '{print $2}')
PORT_NAME=$(networksetup -listallhardwareports | awk -v dev="$DEVICE" '
  BEGIN { found=0 }
  /Hardware Port/ { port=$3 " " $4 }
  /Device/ { if ($2 == dev) { found=1; print port; exit } }
  END { if (!found) { print "N/A" } }')

if [ "$PORT_NAME" = "Wi-Fi" ]; then
  NETWORK_NAME=$(networksetup -getairportnetwork en0 | awk -F': ' '{print $2}')
  sketchybar --set $NAME label="$NETWORK_NAME"
#   sketchybar --set $NAME icon=""
else
  sketchybar --set $NAME label="$PORT_NAME"
#   sketchybar --set $NAME icon=""
fi
