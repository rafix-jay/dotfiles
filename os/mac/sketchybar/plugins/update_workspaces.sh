#!/bin/sh

# Update all workspace indicators
# Run this script to refresh workspace highlighting

echo "Updating workspace indicators..."

# Get current workspace
CURRENT=$(aerospace list-workspaces --focused 2>/dev/null || echo "1")
echo "Current workspace: $CURRENT"

# Update all configured workspaces
for ws in T B C I A M 1 2 3; do
    if [ "$ws" = "$CURRENT" ]; then
        # Highlight active workspace
        sketchybar --set "space.$ws" \
                   background.drawing=on \
                   background.color=0xff8bd5ca \
                   icon.color=0xff000000
        echo "Highlighted workspace: $ws"
    else
        # Regular appearance for inactive workspaces
        sketchybar --set "space.$ws" \
                   background.drawing=off \
                   icon.color=0xffffffff
    fi
done

echo "Workspace indicators updated"