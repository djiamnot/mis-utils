#!/bin/bash


gst-launch ximagesrc startx=0 starty=0 endx=639 endy=479 ! queue ! video/x-raw-rgb,framerate=30/1 ! ffmpegcolorspace ! v4l2sink device=/dev/video0 
