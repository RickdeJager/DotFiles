#!/bin/bash
TMPBG=/tmp/screen.png
BG=~/.i3lock/lowPoly.jpg
LOCK=~/.i3lock/lock.png
RES=1920x1080
 

ffmpeg -i $BG -i -y $LOCK -filter_complex "eq=gamma_r=0.9:gamma_g=0.9:gamma_b=1.1,boxblur=5:5,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG

i3lock -i $TMPBG
