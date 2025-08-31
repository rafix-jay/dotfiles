#!/bin/sh

# Update all AeroSpace workspace indicators
# Run this script to refresh AeroSpace workspace highlighting

echo "Updating AeroSpace workspace indicators..."

# Get current workspace from AeroSpace
if command -v aerospace >/dev/null 2>&1; then
    CURRENT=$(aerospace list-workspaces --focused)
else
    echo "AeroSpace not found"
    exit 1
fi

echo "Current workspace: $CURRENT"

# Update all configured workspaces (matching sketchybarrc configuration)
for workspace in T B C I A M 1 2 3; do
    if [ "$workspace" = "$CURRENT" ]; then
        # Highlight active workspace
        sketchybar --set "space.$workspace" \
                   background.drawing=on \
                   background.color=0xff8bd5ca \
                   icon.color=0xff000000
        echo "Highlighted workspace: $workspace"
    else
        # Regular appearance for inactive workspaces
        sketchybar --set "space.$workspace" \
                   background.drawing=off \
                   icon.color=0xffffffff
    fi
done

echo "AeroSpace workspace indicators updated"