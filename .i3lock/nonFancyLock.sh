#!/bin/bash
TMPBG=/tmp/screen.png
LOCK=~/.i3lock/lock.png
RES=`xdpyinfo | grep -i dimensions: | sed 's/[^0-9]*pixels.*(.*).*//' | sed 's/[^0-9x]*//'`

OFFSET=0

if [ $RES == "3200x1080" ]; then
	OFFSET=640
fi

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "eq=gamma_r=0.9:gamma_g=0.9:gamma_b=1.1,boxblur=5:5,overlay=$OFFSET+(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG


#ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "eq=gamma_r=0.9:gamma_g=0.9:gamma_b=1.1,boxblur=5:5,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG

i3lock -i $TMPBG
