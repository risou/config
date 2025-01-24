#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# uncommit following environment variables
GITHUB_ORG=""

WEEK_START_DATE=$(date -v-monday +%Y-%m-%d)
WEEK_END_DATE=$(date -v+sunday +%Y-%m-%d)
WEEKLY_PR_COUNT=$(gh search prs --merged --merged-at "$WEEK_START_DATE..$WEEK_END_DATE" --owner "$GITHUB_ORG" --author @me --limit 100 --json 'title' -q '.[]|.title' | wc -l | tr -d ' ')

sketchybar --set $NAME label=$WEEKLY_PR_COUNT
