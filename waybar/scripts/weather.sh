#!/bin/sh
# weather.sh — waybar custom/weather module
# Same wttr.in call as the dwmblocks version, wrapped as JSON so
# waybar can show a tooltip on hover.

weather=$(curl -sf "wttr.in/Pune?format=%c+%t+💧%h")

if [ -z "$weather" ]; then
    echo '{"text":"", "tooltip":"Weather unavailable"}'
    exit 0
fi

weather=$(printf '%s' "$weather" | sed 's/ +/+/; s/"/\\"/g')

printf '{"text":"%s","tooltip":"Pune weather (wttr.in)"}\n' "$weather"
