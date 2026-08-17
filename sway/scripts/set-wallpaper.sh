#!/bin/bash
# Apply a single wallpaper: sets it live, regenerates a pywal theme from it,
# and pushes the new colors into sway + waybar.
#
# Usage: set-wallpaper.sh /path/to/image.png

set -uo pipefail

IMG="${1:?usage: set-wallpaper.sh <image>}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

[[ -f "$IMG" ]] || { echo "Error: $IMG not found" >&2; exit 1; }

# 1. set the wallpaper immediately (sway supports live bg changes, no feh needed)
swaymsg output "*" bg "$IMG" fill >/dev/null 2>&1

# 2. generate a pywal theme from it
#    -n = don't let wal try to set the wallpaper itself (we just did it above)
#    -q = quiet
wal -n -q -i "$IMG"

# 3. remember what's active, so the picker can revert on cancel and so
#    update-sway-colors.sh can persist the right `output ... bg` line
mkdir -p "$HOME/.cache"
echo "$IMG" > "$HOME/.cache/current-wallpaper"

# 4. push the new pywal colors into sway + waybar and reload both
"$SCRIPT_DIR/update-sway-colors.sh" "$IMG"
