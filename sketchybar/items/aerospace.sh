#!/bin/bash

SPACE_ICONS=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors --json | jq -r '.[]."monitor-id"'); do
for sid in $(aerospace list-workspaces --monitor $m); do
    current=$(aerospace list-workspaces --monitor $m --visible)
    
    space=(
	icon=${SPACE_ICONS[sid]}
	icon.padding_left=10
	icon.padding_right=15
	display=$m
	padding_left=2
	padding_right=2
	label.padding_right=20
	icon.color=$(( $sid == $current ? $RED : $BLUE))
	label.font="sketchybar-app-font:Regular:16.0"
	label.background.height=26
	label.background.drawing=on
	label.background.color=$BACKGROUND_2
	label.background.corner_radius=8
	label.drawing=off
	script="$PLUGIN_DIR/aerospace_workspace.sh"
    )

    sketchybar --add item space.$sid left \
	       --set space.$sid "${space[@]}" \
	       --subscribe space.$sid mouse.clicked
done
done

spaces=(
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    background.border_width=2
    background.drawing=on
)

separator=(
    icon=􀆊
    icon.font="$FONT:Heavy:16.0"
    padding_left=15
    padding_right=15
    label.drawing=off
    associated_display=active
    click_script=''
    icon.color=$WHITE
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
           --add item separator left          \
           --set separator "${separator[@]}"
