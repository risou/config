#! /bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# uncommit following environment variables
GITHUB_ORG=""

if [ $(date +%m) -le 6 ]; then
  START_DATE=$(date +%Y-01-01)
  END_DATE=$(date +%Y-06-30)
else
  START_DATE=$(date +%Y-07-01) 
  END_DATE=$(date +%Y-12-31)
fi

HALF_YEARLY_PR_COUNT=$(gh search prs --merged --merged-at "$START_DATE..$END_DATE" --owner "$GITHUB_ORG" --author @me --limit 100 --json 'title' -q '.[]|.title' | wc -l | tr -d ' ')

sketchybar --set $NAME label=$HALF_YEARLY_PR_COUNT
