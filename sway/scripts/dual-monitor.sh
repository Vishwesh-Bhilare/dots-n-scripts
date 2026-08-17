#!/usr/bin/env bash

# External monitor
swaymsg output HDMI-A-1 mode 1440x900@59.887Hz
swaymsg output HDMI-A-1 position 0 90

# Laptop display
swaymsg output eDP-1 mode 1920x1080@143.998Hz
swaymsg output eDP-1 position 1440 0

# Assign workspaces to outputs
swaymsg workspace 1 output eDP-1
swaymsg workspace 2 output eDP-1
swaymsg workspace 3 output eDP-1
swaymsg workspace 4 output eDP-1
swaymsg workspace 5 output eDP-1

swaymsg workspace 6 output HDMI-A-1
swaymsg workspace 7 output HDMI-A-1
swaymsg workspace 8 output HDMI-A-1
swaymsg workspace 9 output HDMI-A-1
swaymsg workspace 10 output HDMI-A-1
