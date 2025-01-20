#!/bin/sh

export XDG_RUNTIME_DIR=/tmp/my-xdg-runtime
rm -rf $XDG_RUNTIME_DIR
mkdir $XDG_RUNTIME_DIR && chmod -R 700 $XDG_RUNTIME_DIR

dbus-run-session river 2> $XDG_RUNTIME_DIR/river.err > $XDG_RUNTIME_DIR/river.log


