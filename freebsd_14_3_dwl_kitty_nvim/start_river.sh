#!/bin/sh

export XDG_RUNTIME_DIR=/tmp/my-xdg-runtime
rm -rf $XDG_RUNTIME_DIR
mkdir $XDG_RUNTIME_DIR

export XKB_DEFAULT_OPTIONS=caps:escape
river 2> $XDG_RUNTIME_DIR/river.err > $XDG_RUNTIME_DIR/river.log


