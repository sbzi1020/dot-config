#!/bin/sh

# ----------------------------------------------------------------------------
# Create new `Hare Development` session with multiple windows
# ----------------------------------------------------------------------------

# New session with the default `coding` window and run in background!!!
# Let it run in background is good for creating multiple windows, otherwise, it
# doesn't work!!!
tmux new-session -s "Hare Development" -n hare-quick-manual -c ~/hare/hare-quick-manual -d

# Create the rest windows
tmux new-window -n temp -c ~/hare/temp

# Select the first window
tmux select-window -t 1

# Attach to the ready session (with all created windows)
# tmux attach-session -t "Hare Development"
