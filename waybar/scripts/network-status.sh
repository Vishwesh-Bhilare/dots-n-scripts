#!/usr/bin/env bash
# ~/.config/waybar/scripts/network-status.sh
# Prefers showing whichever connection is actually active:
# ethernet if it's up (even with wifi radio off), otherwise wifi state.

icon_wifi=" "
icon_eth=" "

ethernet=$(nmcli -t -f TYPE,STATE,CONNECTION device | grep '^ethernet:connected')
wifi_radio=$(nmcli -t -f WIFI radio)

if [[ -n "$ethernet" ]]; then
    conn_name=$(echo "$ethernet" | cut -d: -f3)
    if [[ "$wifi_radio" == "disabled" ]]; then
        tooltip="Ethernet: ${conn_name} (Wi-Fi off)"
    else
        tooltip="Ethernet: ${conn_name}"
    fi
    printf '{"text": "%s", "tooltip": "%s", "class": "connected"}\n' "$icon_eth" "$tooltip"
    exit 0
fi

if [[ "$wifi_radio" == "disabled" ]]; then
    printf '{"text": "%s", "tooltip": "Wi-Fi disabled, no Ethernet", "class": "disabled"}\n' "$icon_wifi"
    exit 0
fi

active=$(nmcli -t -f active,ssid dev wifi | grep '^yes')

if [[ -n "$active" ]]; then
    ssid=$(echo "$active" | cut -d: -f2)
    signal=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2)
    printf '{"text": "%s", "tooltip": "Connected: %s (%s%%)", "class": "connected"}\n' "$icon_wifi" "$ssid" "$signal"
else
    printf '{"text": "%s", "tooltip": "Wi-Fi on, not connected", "class": "enabled"}\n' "$icon_wifi"
fi
