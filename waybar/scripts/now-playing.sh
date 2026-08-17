#!/bin/sh
# now-playing.sh — waybar custom/media module
# Same as the original dwmblocks version, but appends a little
# cava-style bar animation next to the title while something is
# actually playing. This isn't reading real audio data (that needs
# cava's raw fifo output) — it just cycles through block characters
# each tick using /dev/urandom, so it *looks* alive. Cheap and good
# enough for a statusbar. Pure POSIX sh, no bashisms.

status=$(playerctl status 2>/dev/null)

if [ -z "$status" ]; then
    echo '{"text":"", "class":"stopped"}'
    exit 0
fi

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)

    if [ -n "$artist" ]; then
        text=" $artist - $title"
    else
        text=" $title"
    fi

    if [ "$status" = "Playing" ]; then
        class="playing"

        # pseudo-cava animation: 5 random bar heights each tick
        # bars="▁▂▃▄▅▆▇█"
		bars=""
        anim=""
        n=0
        while [ "$n" -lt 5 ]; do
            byte=$(od -An -N1 -tu1 /dev/urandom | tr -d ' ')
            idx=$((byte % 8 + 1))
            anim="${anim}$(printf '%s' "$bars" | cut -c"$idx")"
            n=$((n + 1))
        done

        text="$text  $anim"
    else
        class="paused"
    fi

    # escape any double quotes so we don't break the JSON
    text=$(printf '%s' "$text" | sed 's/"/\\"/g')

    printf '{"text":"%s","class":"%s","alt":"%s"}\n' "$text" "$class" "$status"
else
    echo '{"text":"", "class":"stopped"}'
fi
