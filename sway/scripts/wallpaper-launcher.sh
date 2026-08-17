#!/bin/bash
# Interactive wallpaper + pywal theme picker.
#
# Walk through ~/wallpapers with the arrow keys / j,k — each highlighted
# image is swapped in as the wallpaper immediately (cheap: just a
# `swaymsg ... bg` call) so you get instant visual feedback as you scroll.
# The heavier work — regenerating the pywal theme and pushing new colors
# into sway + waybar — only runs ONCE, on the image you actually commit to.
# Doing that on every keypress is what made earlier versions laggy/crashy.
#
#   Enter or q  -> commit to the highlighted wallpaper (runs wal + recolors)
#   Esc / C-c   -> bail out, restore whatever wallpaper was active before
#
# Requires: fzf, kitty (image thumbnails in the preview pane), pywal (wal)
#
# Note: since q is bound to "accept" (per your original ask), it can't be
# typed into the fzf search box. Type to fuzzy-filter with any other
# letters, or just use Enter if you need to search for something with a
# "q" in the filename.

set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
WALL_DIR="${WALLPAPER_DIR:-$HOME/wallpapers}"
PREV_WALL="$(cat "$HOME/.cache/current-wallpaper" 2>/dev/null || true)"

mapfile -t IMAGES < <(find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
    | sort)

if [[ ${#IMAGES[@]} -eq 0 ]]; then
    echo "No wallpapers found in $WALL_DIR" >&2
    exit 1
fi

# Cheap, instant, no wal/waybar involved — just swaps the visible image.
SELECTED=$(printf '%s\n' "${IMAGES[@]}" \
    | fzf \
        --height=100% \
        --layout=reverse \
        --prompt="wallpaper> " \
        --preview 'kitty +kitten icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} 2>/dev/null; echo; basename {}' \
        --preview-window=right:60% \
        --bind 'focus:execute-silent(swaymsg output "*" bg {} fill)' \
        --bind "q:accept")

if [[ -z "$SELECTED" ]]; then
    echo "Cancelled — restoring previous wallpaper." >&2
    if [[ -n "$PREV_WALL" ]]; then
        swaymsg output "*" bg "$PREV_WALL" fill >/dev/null 2>&1
    fi
    exit 130
fi

# Enter/q lands here — this is the ONLY point that runs wal and pushes
# colors into sway + waybar.
"$SCRIPT_DIR/set-wallpaper.sh" "$SELECTED"
echo "Applied: $SELECTED"
