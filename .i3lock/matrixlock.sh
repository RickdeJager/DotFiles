#!/bin/bash
TMPBG=/tmp/screen.png
LOCK=~/.i3lock/hacked.png
RES=1920x1080
 
xterm -fullscreen cmatrix &

sleep 2.5

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG

i3lock -i $TMPBG &
sleep 0.5
killall cmatrix
killall xterm
