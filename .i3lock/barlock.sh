#!/bin/bash
TMPBG=/tmp/screen.png
TMPLK=/tmp/lock.png
LOCK=~/.i3lock/bar.png
RES=`xdpyinfo | grep -i dimensions: | sed 's/[^0-9]*pixels.*(.*).*//' | sed 's/[^0-9x]*//'`
ACTIVE=$(xrandr --listactivemonitors)
XRDB=$(xrdb -query)
FONT="Ubuntu"
LOCKFONTSIZE=150
CLOCKFONTSIZE=80

MAINRES=$(echo "$ACTIVE" | grep 0: | grep -oP "\ \d\d\d*")

OFFSET=$(echo "$ACTIVE" |grep 0: |grep -oP "\+\d*\+" |sed 's/\+//g')

LCOLOR=$(echo "$XRDB" | grep *.color3: | sed 's/\*.color3:\t//')
TCOLOR=$(echo "$XRDB" | grep *.color6: | sed 's/\*.color6:\t//')
COLOR4=$(echo "$XRDB" | grep *.color4: | sed 's/\*.color4:\t//')

convert -quality 100 -fuzz 100% -fill "$LCOLOR" -opaque '#ffffff' "$LOCK" "$TMPLK"

COLOR=$(echo "$XRDB" | grep *.foreground | sed 's/\*.foreground:\t#//')

RED=$(bc <<< "scale=2;$((16#${COLOR:0:2}))/255")
GREEN=$(bc <<< "scale=2;$((16#${COLOR:2:2}))/255")
BLUE=$(bc <<< "scale=2;$((16#${COLOR:4:2}))/255")

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $TMPLK -filter_complex "eq=gamma_r=$RED:gamma_g=$GREEN:gamma_b=$BLUE,boxblur=5:5, overlay=$OFFSET+($MAINRES-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG

HL=$TCOLOR"ff"
NOR=$TCOLOR"7f"
TIMEYPOS=(1080)/2
i3lock 	--clock \
	--timestr="%H:%M" \
	--timepos $OFFSET+270:$TIMEYPOS \
	--timesize $CLOCKFONTSIZE \
	--timecolor=$HL \
	--datepos $OFFSET+720:h/2-25+$LOCKFONTSIZE/2 \
	--datecolor=$HL \
	--datestr="Locked." \
	--datesize $LOCKFONTSIZE \
       	--screen=1 \
       	--ringcolor=$NOR \
       	--keyhlcolor=$HL \
       	--indicator \
	--indpos $OFFSET+270:h/2 \
       	--radius 150 \
       	--insidecolor=#00000000 \
       	-e -f \
       	-i $TMPBG \
