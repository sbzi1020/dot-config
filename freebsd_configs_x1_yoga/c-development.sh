#!/bin/sh

# ----------------------------------------------------------------------------
# Create new `C Development` session with multiple windows
# ----------------------------------------------------------------------------

# New session with the default `coding` window and run in background!!!
# Let it run in background is good for creating multiple windows, otherwise, it
# doesn't work!!!
tmux new-session -s "C Development" -n c-quick-manual -c ~/c/c-quick-manual -d

# Create the rest windows
tmux new-window -n temp-c -c ~/c/temp-c
tmux new-window -n c-utils -c ~/c/c-utils

# Select the first window
tmux select-window -t 1

# Attach to the ready session (with all created windows)
# tmux attach-session -t "C Development"
