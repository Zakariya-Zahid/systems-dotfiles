#!/bin/bash

BAR_HEIGHT=35
TRIGGER=2
VISIBLE=1

while true; do
    eval $(xdotool getmouselocation --shell)

    ACTIVE=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')
    STATE=$(xprop -id $ACTIVE _NET_WM_STATE 2>/dev/null)

    if echo "$STATE" | grep -q FULLSCREEN; then

        if [ "$Y" -le "$TRIGGER" ] && [ "$VISIBLE" -eq 0 ]; then
            polybar-msg cmd show
            VISIBLE=1

        elif [ "$Y" -gt "$BAR_HEIGHT" ] && [ "$VISIBLE" -eq 1 ]; then
            polybar-msg cmd hide
            VISIBLE=0
        fi

    else
        if [ "$VISIBLE" -eq 0 ]; then
            polybar-msg cmd show
            VISIBLE=1
        fi
    fi

    sleep 0.1
done
