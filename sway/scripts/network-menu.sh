#!/usr/bin/env bash
# ~/.config/waybar/scripts/network-menu.sh
# Wofi dropdown for wifi networks. Rescans, lists SSIDs, connects on select.
# Uses your existing ~/.config/wofi/style.css automatically.

wifi_state=$(nmcli -t -f WIFI radio)

if [[ "$wifi_state" == "disabled" ]]; then
    choice=$(printf "Enable Wi-Fi" | wofi --dmenu --prompt "Network" --width 320)
    [[ "$choice" == "Enable Wi-Fi" ]] && nmcli radio wifi on
    exit 0
fi

nmcli device wifi rescan >/dev/null 2>&1

# Build list: current SSID marked, signal shown, plus toggle/disconnect entries.
networks=$(nmcli -t -f IN-USE,SSID,SIGNAL,SECURITY dev wifi list | \
    awk -F: '$2 != "" {
        used = ($1 == "*") ? "● " : "  ";
        lock = ($4 != "--" && $4 != "") ? "  " : "  ";
        printf "%s%s%-24s %s%%\n", used, lock, $2, $3
    }' | sort -u)

menu="${networks}
────────────
Disable Wi-Fi
Rescan"

choice=$(echo "$menu" | wofi --dmenu --prompt "Network" --width 320)

case "$choice" in
    "" ) exit 0 ;;
    "Disable Wi-Fi" ) nmcli radio wifi off ;;
    "Rescan" ) exec "$0" ;;
    "────────────" ) exit 0 ;;
    * )
        ssid=$(echo "$choice" | sed -E 's/^(●| ) +(  | 🔒) //' | sed -E 's/ +[0-9]+%$//')
        # Try existing connection first, fall back to prompting for a password.
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
