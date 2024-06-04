#!/usr/bin/env sh

yabai -m rule --add app="^Slack$" space=9
yabai -m rule --add app="^Arc$" space=9
yabai -m rule --add app="^WezTerm$" space=9
yabai -m rule --add app="^GoLand$" space=4

yabai -m window $(yabai -m query --windows | jq '.[] | select(."app" == "Inkdrop") | .id') --space 9
yabai -m window $(yabai -m query --windows | jq '.[] | select(."app" == "Slack") | .id') --space 9
yabai -m window $(yabai -m query --windows | jq '.[] | select(."app" == "Arc") | .id') --space 9
yabai -m window $(yabai -m query --windows | jq '.[] | select(."app" == "WezTerm") | .id') --space 9
yabai -m window $(yabai -m query --windows | jq '.[] | select(."app" | startswith("GoLand")) | .id') --space 4

echo "yabai allone space mode: ON"
