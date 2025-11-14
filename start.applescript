#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title start
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Jobcan touch
# @raycast.author risou
# @raycast.authorURL https://raycast.com/risou

# Alfredのワークフローを起動するosascriptコマンド
tell application id "com.runningwithcrayons.Alfred" to run trigger "start_from_raycast" in workflow "net.risouf.jobcan-touch"

