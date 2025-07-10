#!/bin/bash

icon=""
# Extract Tctl temperature from sensors output
temp=$(sensors | awk '/k10temp-pci-00c3/{flag=1} flag && /Tctl/ {print $2; exit}')

if [ -n "$temp" ]; then
    echo "$icon $temp"
else
    echo "Cpu: N/A"
fi
