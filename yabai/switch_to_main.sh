#!/bin/bash

current_display=$(yabai -m query --windows | jq '.[] | select(."has-focus" == true) | .display')

# アクティブなウィンドウがサブディスプレイ側にある場合のみ
if [ current_display != 1 ]; then
    # メインディスプレイのウィンドウを全てサブディスプレイに移動
    main_display_windows=$(yabai -m query --windows --display 1 | jq '.[] | select(."is-visible" == true) | .id')
    for id in $main_display_windows ; do
        yabai -m window $id --display $current_display
    done

    # アクティブなウィンドウをメインディスプレイに移動
    yabai -m window --display 1
    # フォーカスをメインディスプレイのウィンドウに移動
    yabai -m display --focus 1
fi

