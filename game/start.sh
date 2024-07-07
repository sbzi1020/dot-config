#!/bin/sh

# -load-state=<file>      Load save state after starting
# -window-pos=<x>,<y>     Window position [Default: centered]
# -fullscreen             Full screen mode
# -wide-screen            Expand 3D field of view to screen width
# -wide-bg                When wide-screen mode is enabled, also expand the 2D background layer to screen width
# -stretch                Fit viewport to resolution, ignoring aspect ratio
# -no-vsync               Do not lock to vertical refresh rate
# -true-hz                Use true Model 3 refresh rate of 57.524 Hz
# -show-fps               Display frame rate in window title bar
# -new3d                  New 3D engine by Ian Curtis [Default]
# -quad-rendering         Enable proper quad rendering
# -legacy3d               Legacy 3D engine (faster but less accurate)
# -multi-texture          Use 8 texture maps for decoding (legacy engine)

./supermodel ./ROMs/spikeofe.zip \
    -game-xml-file=./Config/Games.xml \
    -log-output=./Log/game.log \
    -ppc-frequency=49 \
    -gpu-multi-threaded \
    -res=800,600 \
    -window \
    -borderless \
    -no-throttle \
    -vsync \
    -crosshairs=0 \
    -new3d \
    -no-multi-texture \
    -sound-volume=100 \
    -music-volume=20 \
    -balance=0 \
    -flip-stereo
