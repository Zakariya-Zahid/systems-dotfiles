#!/usr/bin/env bash
BG_DIR="/home/zak/.config/i3lock/backgrounds/"
BG=$(find "$BG_DIR" -type f | shuf -n 1)
# Use absolute path to i3lock-color binary
/usr/bin/i3lock \
    --image "$BG" \
    --insidecolor=00000000 \
    --ringcolor=88c0d0ff \
    --linecolor=00000000 \
    --keyhlcolor=b48eadff \
    --insidevercolor=bf616aff \
    --insidewrongcolor=bf616aff \
    --ringvercolor=a3be8cff \
    --ringwrongcolor=bf616aff \
    --verifcolor=d8dee9ff \
    --wrongcolor=bf616aff \
    --timecolor=d8dee9ff \
    --datecolor=88c0d0ff \
    --clock

