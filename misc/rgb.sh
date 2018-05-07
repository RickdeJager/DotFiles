#!/bin/bash
#This script grabs a hex color from xrdb (placed there by pywal) and sends it of to my arduino to make my rgb match the current desktop. Why? because I can.
TTY=/dev/ttyUSB0

COLOR=`xrdb -query | grep *.color2 | sed 's/\*.color2:\t#//'`

#Convert the color to RGB
RED=$(bc <<< "scale=2;$((16#${COLOR:0:2}))")
GREEN=$(bc <<< "scale=2;$((16#${COLOR:2:2}))")
BLUE=$(bc <<< "scale=2;$((16#${COLOR:4:2}))")

#Add leading 0's
RED=$(printf "%03d" $RED)
GREEN=$(printf "%03d" $GREEN)
BLUE=$(printf "%03d" $BLUE)

#Open a connection and sleep 1 sec to make sure it's ready
stty -F $TTY cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts -hupcl
sleep 2

TEMP=$RED$GREEN$BLUE
echo $TEMP
echo $TEMP >$TTY

#stty -F $TTY hupcl
