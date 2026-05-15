#!/bin/bash

prompt_20_20_20() {

    RED="\033[1;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"

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
    local remains_minutes=$((difference / 60))
    local remains_seconds=$((difference % 60))

    local color
    if ((difference < 20)); then
        color="$YELLOW"
    else
        color="$GREEN"
    fi

    local state_file="/tmp/prompt-20-20-20.state"
    local previous_limit
    local missed=false

    if [[ -f "$state_file" ]]; then
        previous_limit=$(cat "$state_file" 2>/dev/null)
        if [[ -n "$previous_limit" && "$previous_limit" -ne $time_limit ]]; then
            missed=true
        fi
    fi

    echo "$time_limit" >"${state_file}.tmp" 2>/dev/null &&
        mv "${state_file}.tmp" "$state_file" 2>/dev/null

    if ($missed); then
        color="$RED"
    fi

    printf "${color}[%02d:%02d]\033[0m" "$remains_minutes" "$remains_seconds"
}
