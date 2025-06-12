#!/usr/bin/env bash

# Wait a moment to ensure X and Plasma are ready
sleep 2

# Terminate any existing Polybar instances
killall -q polybar

# Launch your bar; replace ‘exi’ with your actual bar name
echo "---" | tee -a /tmp/polybar.log
polybar exi 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar (exi) launched"
