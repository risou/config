#!/bin/bash

# 現在フォーカスされているウィンドウのIDを取得
focused_window=$(yabai -m query --windows --window | jq '.id')

# 現在のディスプレイ番号を取得
current_display=$(yabai -m query --windows --window | jq '.display')

# 移動先のディスプレイ番号を決定
# target_display=$((current_display == 1 ? 2 : 1))
target_display=2
# 移動先のディスプレイ番号を決定
if [ "$current_display" -eq "$target_display" ]; then
    destination_display=1
else
    destination_display=$current_display
fi


# フォーカスされているウィンドウを目標のディスプレイに移動
yabai -m window --display $target_display

# 元のディスプレイにあった全てのウィンドウを現在のディスプレイに移動
yabai -m query --windows | jq -r ".[] | select(.display == $target_display and .id != $focused_window).id" | while read -r window_id; do
    yabai -m window $window_id --display $destination_display
done

# 移動したウィンドウにフォーカスを移す
yabai -m display --focus $target_display 