#!/bin/bash
# Kill existing Polybar instances
killall -q polybar

# Wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -c ~/.config/polybar/config.ini main &
