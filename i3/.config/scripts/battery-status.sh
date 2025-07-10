#!/bin/bash

# Try common battery paths
battery_path=""
for bat in /sys/class/power_supply/BAT*; do
    if [ -e "$bat/capacity" ]; then
        battery_path="$bat"
        break
    fi
done

if [ -z "$battery_path" ]; then
    echo "󰣇?%"  # Fallback icon
    exit 1
fi

capacity=$(cat "$battery_path/capacity")

# Choose icon based on capacity (using Font Awesome)
if [ "$capacity" -gt 90 ]; then
    icon="󰣇"  # Full
elif [ "$capacity" -gt 60 ]; then
    icon="󰣇"  # Three-quarters
elif [ "$capacity" -gt 40 ]; then
    icon="󰣇"  # Half
elif [ "$capacity" -gt 15 ]; then
    icon="󰣇"  # Quarter
else
    icon="󰣇"  # Empty
fi

# Color logic
if [ "$capacity" -gt 50 ]; then
    color="%{F#FDFD96}"  # Green
else
    color="%{F#FF5555}"  # Red
fi

# Output (forcing Font Awesome if needed)
echo "${color}%{T1}${icon}%{T-} ${capacity}%%{F-}"