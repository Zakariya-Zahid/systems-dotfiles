#!/usr/bin/env python

import i3ipc
import subprocess

i3 = i3ipc.Connection()

def on_window_event(i3, e):
    if e.change == "fullscreen_mode":
        if e.container.fullscreen_mode == 1:
            subprocess.run(["polybar-msg", "cmd", "hide"])
        else:
            subprocess.run(["polybar-msg", "cmd", "show"])

i3.on("window", on_window_event)
i3.main()
