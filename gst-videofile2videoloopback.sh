#!/bin/bash

echo "Remember to modprobe v4l2loopback"
gst-launch -v filesrc location=$1 ! decodebin ! ffmpegcolorspace ! v4l2sink device=/dev/video0
