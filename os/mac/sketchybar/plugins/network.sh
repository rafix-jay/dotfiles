#!/bin/sh

# Network status widget for Sketchybar
# Shows WiFi network name or Ethernet status

# Function to get network info
get_network_info() {
    # Get default route interface
    DEFAULT_INTERFACE=$(route -n get default 2>/dev/null | grep "interface:" | awk '{print $2}')
    
    # Check for WiFi connection on common interfaces
    for wifi_interface in en0 en1; do
        WIFI_OUTPUT=$(networksetup -getairportnetwork $wifi_interface 2>/dev/null)
        if echo "$WIFI_OUTPUT" | grep -q "Current Wi-Fi Network:"; then
            WIFI_NETWORK=$(echo "$WIFI_OUTPUT" | sed 's/Current Wi-Fi Network: //')
            echo "wifi|$WIFI_NETWORK|📶"
            return
        fi
    done
    
    # Check if we have any active network connection
    if [ -n "$DEFAULT_INTERFACE" ]; then
        # Check if it's ethernet-like
        case "$DEFAULT_INTERFACE" in
            en*)
                # Get interface type from system profiler (simplified)
                echo "ethernet|Connected|🔗"
                ;;
            *)
                echo "other|Connected|🌐"
                ;;
        esac
    else
        echo "none|No Connection|❌"
    fi
}

# Get network information
NETWORK_INFO=$(get_network_info)
NETWORK_TYPE=$(echo "$NETWORK_INFO" | cut -d'|' -f1)
NETWORK_NAME=$(echo "$NETWORK_INFO" | cut -d'|' -f2)
NETWORK_ICON=$(echo "$NETWORK_INFO" | cut -d'|' -f3)

# Limit network name length
if [ ${#NETWORK_NAME} -gt 15 ]; then
    NETWORK_NAME=$(echo "$NETWORK_NAME" | cut -c1-12)...
fi

# Set colors based on connection type
case "$NETWORK_TYPE" in
    "wifi")
        COLOR="0xff6bcf7f"  # Green
        ;;
    "ethernet")
        COLOR="0xff74c0fc"  # Blue
        ;;
    "none")
        COLOR="0xffff6b6b"  # Red
        ;;
    *)
        COLOR="0xffffffff"  # White
        ;;
esac

# Set the network widget
sketchybar --set "$NAME" \
           icon="$NETWORK_ICON" \
           label="$NETWORK_NAME" \
           icon.color="$COLOR"