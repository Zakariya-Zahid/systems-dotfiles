#!/bin/bash

while true; do
    eval $(xdotool getmouselocation --shell)

    if [ "$Y" -le 2 ]; then
        polybar-msg cmd show
    fi

    sleep 0.1
done
