#!/bin/bash

CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')

if [ -z "$CPU_USAGE" ]; then
    CPU_USAGE=0
fi

sketchybar --set $NAME label="$CPU_USAGE%"