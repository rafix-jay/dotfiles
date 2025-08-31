#!/bin/sh

# Apple Music media widget for Sketchybar
# Shows currently playing song and artist

# Function to get Apple Music status using AppleScript
get_apple_music_info() {
    osascript -e '
    tell application "System Events"
        if (exists process "Music") then
            tell application "Music"
                if player state is playing then
                    set trackName to name of current track
                    set artistName to artist of current track
                    return trackName & " - " & artistName
                else
                    return "paused"
                end if
            end tell
        else
            return "not_running"
        end if
    end tell
    ' 2>/dev/null
}

# Get current media info
MEDIA_INFO=$(get_apple_music_info)

# Handle different states
case "$MEDIA_INFO" in
    "not_running"|"paused"|"")
        # Hide the media widget when not playing
        sketchybar --set "$NAME" drawing=off
        ;;
    *)
        # Show media info when playing
        # Limit length to prevent overflow
        if [ ${#MEDIA_INFO} -gt 50 ]; then
            MEDIA_INFO=$(echo "$MEDIA_INFO" | cut -c1-47)...
        fi
        
        sketchybar --set "$NAME" \
                   icon="♫" \
                   label="$MEDIA_INFO" \
                   drawing=on
        ;;
esac