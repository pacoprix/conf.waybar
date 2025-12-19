#!/bin/bash

# Toggle power profile using powerprofilesctl or system76-power
if command -v powerprofilesctl &> /dev/null; then
    current=$(powerprofilesctl get)
    
    case "$current" in
        "power-saver")
            powerprofilesctl set balanced
            notify-send -u low "Power Profile" "Switched to Balanced mode"
            ;;
        "balanced")
            powerprofilesctl set performance
            notify-send -u low "Power Profile" "Switched to Performance mode"
            ;;
        "performance")
            powerprofilesctl set power-saver
            notify-send -u low "Power Profile" "Switched to Power Saver mode"
            ;;
    esac
elif command -v system76-power &> /dev/null; then
    current=$(system76-power profile | grep -oP '(?<=Profile: )\w+')
    
    case "$current" in
        "battery")
            system76-power profile balanced
            notify-send -u low "Power Profile" "Switched to Balanced mode"
            ;;
        "balanced")
            system76-power profile performance
            notify-send -u low "Power Profile" "Switched to Performance mode"
            ;;
        "performance")
            system76-power profile battery
            notify-send -u low "Power Profile" "Switched to Battery mode"
            ;;
    esac
else
    notify-send -u critical "Power Profile" "No power profile daemon found"
fi
