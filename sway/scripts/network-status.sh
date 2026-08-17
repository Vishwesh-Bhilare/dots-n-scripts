#!/usr/bin/env bash
# ~/.config/waybar/scripts/network-status.sh
# Outputs waybar JSON: icon + tooltip, reflects current connection state.

state=$(nmcli -t -f STATE general status)
active=$(nmcli -t -f TYPE,STATE,CONNECTION device | grep -E '^wifi:connected|^ethernet:connected' | head -n1)

if [[ "$state" == "disconnected" ]]; then
    text=" Offline"
    tooltip="Not connected"
    class="disconnected"
elif [[ "$active" == wifi:* ]]; then
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    signal=$(nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2)
    text="  ${ssid}"
    tooltip="Wi-Fi: ${ssid} (${signal}%)"
    class="wifi"
elif [[ "$active" == ethernet:* ]]; then
    text="  Wired"
    tooltip="Ethernet connected"
    class="wired"
else
    text=" No connection"
    tooltip="Not connected"
    class="disconnected"
fi

printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$text" "$tooltip" "$class"
