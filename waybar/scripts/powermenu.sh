#!/usr/bin/env bash
# Requires: wofi

entries="  Lock\n  Logout\n  Suspend\n  Reboot\n  Shutdown"

selected=$(echo -e "$entries" | wofi --dmenu --width 220 --height 220 \
    --style ~/.config/waybar/scripts/powermenu.css 2>/dev/null | sed 's/^[^ ]* //')

case "$selected" in
    Lock)      swaylock -f ;;
    Logout)    swaymsg exit ;;
    Suspend)   systemctl suspend ;;
    Reboot)    systemctl reboot ;;
    Shutdown)  systemctl poweroff ;;
esac
