#!/usr/bin/env bash
# ~/.config/waybar/scripts/network-menu.sh
# Wofi dropdown for wifi networks. Rescans, lists SSIDs, connects on select.
# Disabling Wi-Fi here only turns off the radio -- Ethernet, if active, is untouched.

wifi_state=$(nmcli -t -f WIFI radio)
ethernet=$(nmcli -t -f TYPE,STATE,CONNECTION device | grep '^ethernet:connected')

if [[ "$wifi_state" == "disabled" ]]; then
    if [[ -n "$ethernet" ]]; then
        prompt="Enable Wi-Fi (Ethernet active)"
    else
        prompt="Enable Wi-Fi"
    fi
    choice=$(printf "%s" "$prompt" | wofi --dmenu --prompt "Network" --width 320)
    [[ "$choice" == "$prompt" ]] && nmcli radio wifi on
    exit 0
fi

nmcli device wifi rescan >/dev/null 2>&1

networks=$(nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list | \
    awk -F: '$2 != "" {
        used = ($1 == "*") ? "● " : "  ";
        lock = ($4 != "--" && $4 != "") ? "  " : "  ";
        printf "%s%s%-24s %s%%\n", used, lock, $2, $3
    }' | sort -u)

if [[ -n "$ethernet" ]]; then
    disable_label="Disable Wi-Fi (use Ethernet)"
else
    disable_label="Disable Wi-Fi"
fi

menu="${networks}
────────────
${disable_label}
Rescan"

choice=$(echo "$menu" | wofi --dmenu --prompt "Network" --width 320)

case "$choice" in
    "" ) exit 0 ;;
    "$disable_label" ) nmcli radio wifi off ;;
    "Rescan" ) exec "$0" ;;
    "────────────" ) exit 0 ;;
    * )
        ssid=$(echo "$choice" | sed -E 's/^(●| ) +(  | 🔒) //' | sed -E 's/ +[0-9]+%$//')
        if nmcli connection up id "$ssid" >/dev/null 2>&1; then
            notify-send "Network" "Connected to $ssid"
        else
            pass=$(wofi --dmenu --password --prompt "Password for $ssid" --width 320)
            [[ -z "$pass" ]] && exit 0
            if nmcli device wifi connect "$ssid" password "$pass" >/dev/null 2>&1; then
                notify-send "Network" "Connected to $ssid"
            else
                notify-send "Network" "Failed to connect to $ssid"
            fi
        fi
        ;;
esac
