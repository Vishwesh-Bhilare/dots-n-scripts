#!/usr/bin/env bash
# ~/.config/waybar/scripts/bluetooth-menu.sh
# Wofi dropdown for Bluetooth: toggle power, connect/disconnect paired devices, scan.

powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ "$powered" != "yes" ]]; then
    choice=$(printf "Enable Bluetooth" | wofi --dmenu --prompt "Bluetooth" --width 320)
    [[ "$choice" == "Enable Bluetooth" ]] && bluetoothctl power on
    exit 0
fi

# List paired devices with connection state.
devices=$(bluetoothctl devices Paired | while read -r _ mac name; do
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        echo "● ${name} (${mac})"
    else
        echo "  ${name} (${mac})"
    fi
done)

menu="${devices}
────────────
Scan for devices
Disable Bluetooth"

choice=$(echo "$menu" | wofi --dmenu --prompt "Bluetooth" --width 320)
mac=$(echo "$choice" | grep -oE '([0-9A-F]{2}:){5}[0-9A-F]{2}')

case "$choice" in
    "" ) exit 0 ;;
    "Disable Bluetooth" ) bluetoothctl power off ;;
    "Scan for devices" )
        notify-send "Bluetooth" "Scanning for 8s..."
        bluetoothctl --timeout 8 scan on
        exec "$0"
        ;;
    "────────────" ) exit 0 ;;
    * )
        if [[ -n "$mac" ]]; then
            if echo "$choice" | grep -q "^●"; then
                bluetoothctl disconnect "$mac"
                notify-send "Bluetooth" "Disconnected"
            else
                bluetoothctl connect "$mac"
                notify-send "Bluetooth" "Connecting..."
            fi
        fi
        ;;
esac
