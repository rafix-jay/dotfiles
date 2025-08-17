#!/bin/sh

# AeroSpace workspace integration
# Get current AeroSpace workspace with fallback
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null || echo "1")

# Extract workspace ID from the space item name (e.g., "space.A" -> "A")
WORKSPACE_ID=${NAME#space.}

# Check if this workspace is currently focused
if [ "$WORKSPACE_ID" = "$CURRENT_WORKSPACE" ]; then
    # Highlight the active workspace
    sketchybar --set "$NAME" background.drawing=on \
                             background.color=0xff8bd5ca \
                             icon.color=0xff000000
else
    # Regular appearance for inactive workspaces
    sketchybar --set "$NAME" background.drawing=off \
                             icon.color=0xffffffff
fi

# Also trigger a general workspace refresh if this is called manually
if [ "$1" = "refresh" ]; then
    /Users/rafix/.config/sketchybar/plugins/update_workspaces.sh
fi
