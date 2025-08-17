#!/bin/sh

# Weather widget for Sketchybar using macOS Weather app data
# Uses AppleScript to get weather from native Weather app

# Function to get weather from macOS Weather app
get_weather_from_app() {
    osascript -e '
    tell application "Weather"
        try
            -- Get current weather for default location
            set currentTemp to temperature
            set currentCondition to description
            return (currentTemp as string) & "°|" & (currentCondition as string)
        on error
            return "error"
        end try
    end tell
    ' 2>/dev/null
}

# Try to get weather from macOS Weather app first
WEATHER_DATA=$(get_weather_from_app)

# If Weather app fails, fallback to wttr.in
if [ "$WEATHER_DATA" = "error" ] || [ -z "$WEATHER_DATA" ]; then
    # Fallback to external API
    WEATHER_API_DATA=$(curl -s "wttr.in/?format=%t+%C" 2>/dev/null)
    
    # Check if we got valid data from API
    if [ -z "$WEATHER_API_DATA" ] || [ "$WEATHER_API_DATA" = "Unknown location" ]; then
        # Final fallback to Berlin
        WEATHER_API_DATA=$(curl -s "wttr.in/Berlin?format=%t+%C" 2>/dev/null)
    fi
    
    if [ -n "$WEATHER_API_DATA" ]; then
        TEMP=$(echo "$WEATHER_API_DATA" | awk '{print $1}')
        CONDITION=$(echo "$WEATHER_API_DATA" | cut -d' ' -f2-)
    else
        TEMP="--°"
        CONDITION="Unknown"
    fi
else
    # Parse Weather app data
    TEMP=$(echo "$WEATHER_DATA" | cut -d'|' -f1)
    CONDITION=$(echo "$WEATHER_DATA" | cut -d'|' -f2)
fi

# Map weather conditions to icons
case "$CONDITION" in
    *"Clear"*|*"Sunny"*|*"Fair"*) ICON="☀️" ;;
    *"Partly"*|*"Few"*|*"Scattered"*) ICON="⛅" ;;
    *"Cloudy"*|*"Overcast"*|*"Broken"*) ICON="☁️" ;;
    *"Rain"*|*"Drizzle"*|*"Shower"*|*"Precipitation"*) ICON="🌧️" ;;
    *"Snow"*|*"Sleet"*|*"Flurries"*) ICON="❄️" ;;
    *"Thunder"*|*"Storm"*|*"T-Storm"*) ICON="⛈️" ;;
    *"Mist"*|*"Fog"*|*"Haze"*) ICON="🌫️" ;;
    *"Wind"*|*"Breezy"*) ICON="💨" ;;
    *"Hot"*) ICON="🔥" ;;
    *"Cold"*) ICON="🥶" ;;
    *) ICON="🌤️" ;;  # Default/partly sunny
esac

# Set the weather widget
if [ "$TEMP" != "--°" ] && [ -n "$TEMP" ]; then
    sketchybar --set "$NAME" icon="$ICON" label="$TEMP"
else
    # Error state
    sketchybar --set "$NAME" icon="❓" label="--°"
fi