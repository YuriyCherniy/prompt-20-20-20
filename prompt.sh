#!/bin/bash

prompt() {

    local minutes=$((10#$(date +%M)))
    local seconds=$((10#$(date +%S)))
    local total_seconds=$((minutes * 60 + seconds))

    local time_limit
    if [[ $total_seconds -lt 1200 ]]; then
        time_limit=1200
    elif [[ $total_seconds -lt 2400 ]]; then
        time_limit=2400
    else
        time_limit=3600
    fi

    local difference=$((time_limit - total_seconds))

    local remains_minuts=$((difference / 60))
    local remains_seconds=$((difference % 60))

    local color
    if ((difference < 20)); then
        color="\033[0;31m"
    else
        color="\033[0;32m"
    fi

    printf "${color}[%02d:%02d]\033[0m" "$remains_minuts" "$remains_seconds"
}
