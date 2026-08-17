#!/usr/bin/env bash
# ~/.config/waybar/scripts/bluetooth-status.sh
# Icon-only: power/connection state -> class (disabled/enabled/connected), tooltip has detail.

icon="󰂯"

powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ "$powered" != "yes" ]]; then
    printf '{"text": "%s", "tooltip": "Bluetooth disabled", "class": "disabled"}\n' "$icon"
    exit 0
fi

connected=$(bluetoothctl devices Connected)

if [[ -z "$connected" ]]; then
    printf '{"text": "%s", "tooltip": "Bluetooth on, no devices connected", "class": "enabled"}\n' "$icon"
else
    names=$(echo "$connected" | awk '{$1=$2=""; print $0}' | sed 's/^ *//' | paste -sd, -)
    printf '{"text": "%s", "tooltip": "Connected: %s", "class": "connected"}\n' "$icon" "$names"
fi
