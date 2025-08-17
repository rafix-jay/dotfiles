#!/bin/sh

# Disk usage widget for Sketchybar
# Shows main disk usage percentage

# Get disk usage for the root filesystem
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# Color coding based on usage
if [ "$DISK_USAGE" -ge 90 ]; then
    COLOR="0xffff6b6b"  # Red - Critical
    ICON="🔴"
elif [ "$DISK_USAGE" -ge 80 ]; then
    COLOR="0xffffd93d"  # Yellow - Warning
    ICON="🟡"
elif [ "$DISK_USAGE" -ge 70 ]; then
    COLOR="0xffff9f43"  # Orange - Caution
    ICON="🟠"
else
    COLOR="0xff6bcf7f"  # Green - Good
    ICON="💾"
fi

# Set the disk widget
sketchybar --set "$NAME" \
           icon="$ICON" \
           label="${DISK_USAGE}%" \
           icon.color="$COLOR"