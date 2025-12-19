#!/bin/bash

# Get current power profile
if command -v powerprofilesctl &> /dev/null; then
    profile=$(powerprofilesctl get)
elif command -v system76-power &> /dev/null; then
    profile=$(system76-power profile | grep -oP '(?<=Profile: )\w+')
else
    profile="unknown"
fi

# Map profile names to standard names
case "$profile" in
    "power-saver"|"battery")
        text="Power Saver"
        icon="power-saver"
        ;;
    "balanced")
        text="Balanced"
        icon="balanced"
        ;;
    "performance")
        text="Performance"
        icon="performance"
        ;;
    *)
        text="Unknown"
        icon="balanced"
        ;;
esac

# Output JSON for waybar
echo "{\"text\":\"$text\",\"alt\":\"$icon\",\"tooltip\":\"Power Mode: $text\",\"class\":\"$icon\"}"
