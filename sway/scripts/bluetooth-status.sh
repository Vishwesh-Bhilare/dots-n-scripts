#!/usr/bin/env bash
# ~/.config/waybar/scripts/bluetooth-status.sh
# Outputs waybar JSON: icon + tooltip, reflects power state and connected devices.

powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ "$powered" != "yes" ]]; then
    printf '{"text": " Off", "tooltip": "Bluetooth disabled", "class": "off"}\n'
    exit 0
fi

connected=$(bluetoothctl devices Connected)

if [[ -z "$connected" ]]; then
    printf '{"text": " On", "tooltip": "No devices connected", "class": "on"}\n'
else
    names=$(echo "$connected" | awk '{$1=$2=""; print $0}' | sed 's/^ *//' | paste -sd, -)
    printf '{"text": " %s", "tooltip": "Connected: %s", "class": "connected"}\n' "$names" "$names"
fi
