#!/bin/sh

# Memory/RAM usage widget for Sketchybar
# Shows memory usage percentage with color coding

# Get memory stats
MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')
USED_MEMORY=$(echo "100 - $MEMORY_PRESSURE" | bc)

# Alternative method using vm_stat if memory_pressure fails
if [ -z "$USED_MEMORY" ] || [ "$USED_MEMORY" = "100 - " ]; then
    # Use vm_stat as fallback
    VM_STAT=$(vm_stat)
    PAGES_FREE=$(echo "$VM_STAT" | grep "Pages free" | awk '{print $3}' | tr -d '.')
    PAGES_ACTIVE=$(echo "$VM_STAT" | grep "Pages active" | awk '{print $3}' | tr -d '.')
    PAGES_INACTIVE=$(echo "$VM_STAT" | grep "Pages inactive" | awk '{print $3}' | tr -d '.')
    PAGES_SPECULATIVE=$(echo "$VM_STAT" | grep "Pages speculative" | awk '{print $3}' | tr -d '.')
    PAGES_WIRED=$(echo "$VM_STAT" | grep "Pages wired down" | awk '{print $4}' | tr -d '.')
    
    # Calculate total pages
    TOTAL_PAGES=$((PAGES_FREE + PAGES_ACTIVE + PAGES_INACTIVE + PAGES_SPECULATIVE + PAGES_WIRED))
    USED_PAGES=$((PAGES_ACTIVE + PAGES_INACTIVE + PAGES_SPECULATIVE + PAGES_WIRED))
    
    # Calculate percentage
    if [ "$TOTAL_PAGES" -gt 0 ]; then
        USED_MEMORY=$((USED_PAGES * 100 / TOTAL_PAGES))
    else
        USED_MEMORY=0
    fi
fi

# Color coding based on usage
if [ "$USED_MEMORY" -ge 80 ]; then
    COLOR="0xffff6b6b"  # Red
    ICON="🔴"
elif [ "$USED_MEMORY" -ge 60 ]; then
    COLOR="0xffffd93d"  # Yellow
    ICON="🟡"
else
    COLOR="0xff6bcf7f"  # Green
    ICON="🟢"
fi

# Set the memory widget
sketchybar --set "$NAME" \
           icon="$ICON" \
           label="${USED_MEMORY}%" \
           icon.color="$COLOR"