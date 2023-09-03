#!/bin/bash

cd $HOME
if [ -e jobcan_worktime ]; then
    worktime=$(expr $(date +%s) - $(cat jobcan_worktime))
    let hours="$worktime/3600"
    let minutes="($worktime%3600)/60"
    printf "%02d:%02d" $hours $minutes
else
    echo "--:--"
fi
