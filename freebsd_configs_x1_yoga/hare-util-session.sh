#!/bin/sh

# ----------------------------------------------------------------------------
# Create new `Hare Utils` session with multiple windows
# ----------------------------------------------------------------------------

# New session with the default `coding` window and run in background!!!
# Let it run in background is good for creating multiple windows, otherwise, it
# doesn't work!!!
tmux new-session -s "Hare Utils" -n coding -c ~/hare/hare-utils -d

# Create the rest windows
tmux new-window -n unit-test -c ~/hare/hare-utils
tmux new-window -n stdlib -c `hare version -v | rg stdlib`

# Select the first window
tmux select-window -t 1

# Attach to the ready session (with all created windows)
# tmux attach-session -t "Hare Utils"
