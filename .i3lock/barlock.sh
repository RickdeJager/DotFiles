#!/bin/bash
TMPBG=/tmp/screen.png
TMPLK=/tmp/lock.png
LOCK=~/.i3lock/bar.png
RES=`xdpyinfo | grep -i dimensions: | sed 's/[^0-9]*pixels.*(.*).*//' | sed 's/[^0-9x]*//'`
FONT="Ubuntu"
LOCKFONTSIZE=150
CLOCKFONTSIZE=80


OFFSET=0

if [ $RES == "3200x1080" ]; then
	OFFSET=640
elif [ $RES == "3840x1080" ]; then
	OFFSET=-960
fi


LCOLOR=`xrdb -query | grep *.color3: | sed 's/\*.color3:\t//'`
TCOLOR=`xrdb -query | grep *.color6: | sed 's/\*.color6:\t//'`
COLOR4=`xrdb -query | grep *.color4: | sed 's/\*.color4:\t//'`

COMMAND="convert -quality 100 -fuzz 100% -fill '""$LCOLOR""' -opaque '#ffffff' $LOCK $TMPLK"
#This step is needed because of the ''s
eval $COMMAND

COLOR=`xrdb -query | grep *.foreground | sed 's/\*.foreground:\t#//'`

RED=$(bc <<< "scale=2;$((16#${COLOR:0:2}))/255")
GREEN=$(bc <<< "scale=2;$((16#${COLOR:2:2}))/255")
BLUE=$(bc <<< "scale=2;$((16#${COLOR:4:2}))/255")

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $TMPLK -filter_complex "eq=gamma_r=$RED:gamma_g=$GREEN:gamma_b=$BLUE,boxblur=5:5, overlay=$OFFSET+(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG

HL=$TCOLOR"ff"
NOR=$TCOLOR"7f"
TIMEYPOS=(1080)/2
i3lock 	--clock \
	--timestr="%H:%M" \
	--timepos 270:$TIMEYPOS \
	--timesize $CLOCKFONTSIZE \
	--timecolor=$HL \
	--datepos 720:h/2-25+$LOCKFONTSIZE/2 \
	--datecolor=$HL \
	--datestr="Locked." \
	--datesize $LOCKFONTSIZE \
       	--screen=1 \
       	--ringcolor=$NOR \
       	--keyhlcolor=$HL \
       	--indicator \
	--indpos 270:h/2 \
       	--radius 150 \
       	--insidecolor=#00000000 \
       	-e -f \
       	-i $TMPBG \
