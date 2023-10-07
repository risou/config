#!/bin/bash

displays=$(yabai -m query --displays | jq '.[] | .index')
focused_space=$(yabai -m query --windows | jq '.[] | select(."has-focus" == true) | .space')
focused_position=$(yabai -m query --windows --space $focused_space | jq 'sort_by(.frame.x + .frame.y) | to_entries | map(select(.value."has-focus" == true)) | .[].key')

for d in $displays ; do
    sp=$(yabai -m query --spaces --display $d | jq '.[] | select(."is-visible" == true) | .index')
    win=$(yabai -m query --windows --space $sp | jq 'sort_by(.frame.x + .frame.y) | .[0].id')

    n=$(( d - 1 ))
    yabai -m window $win --display $n &> /dev/null
    if [[ $? -eq 1 ]]; then
        yabai -m window $win --display last
        n=$(yabai -m query --displays | jq 'length')
    fi
    yabai -m window --focus $win
    while : ; do
        yabai -m window $win --swap next &> /dev/null
        if [[ $? -eq 1 ]]; then
            break
        fi
    done
done

first_window=$(yabai -m query --spaces --space $focused_space | jq '."first-window"')
yabai -m window $first_window --focus
for i in `seq $focused_position` ; do
    yabai -m window --focus next
done

