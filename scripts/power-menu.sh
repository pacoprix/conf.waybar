#!/bin/bash

# Power menu script for Waybar

options="Logout\nRestart\nShutdown\nHibernate"

command=$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 200 --height 180 --insensitive)

case $command in
    "Logout")
        # For Hyprland
        if command -v hyprctl &> /dev/null; then
            hyprctl dispatch exit
        # For sway
        elif command -v swaymsg &> /dev/null; then
            swaymsg exit
        else
            loginctl terminate-user $USER
        fi
        ;;
    "Restart")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    "Hibernate")
        # sudo pm-hibernate
        hyprlock & sleep 0.5 && sudo pm-hibernate
        ;;
esac
