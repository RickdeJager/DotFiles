#!/bin/bash

getDif() {
	: "${1/\#}"
	((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
	dif=0
	t=$(($r-$b))
	t=${t#-}
	if (($t > $dif)) ; then
		dif=$t
	fi
	t=$(($r-$g))
	t=${t#-}
	if (($t > $dif)) ; then
		dif=$t
	fi
	t=$(($b-$g))
	t=${t#-}
	if (($t > $dif)) ; then
		dif=$t
	fi
	printf "$dif\n"
}


LIST=$(xrdb -query)

maxDif=0
maxi=0
maxColor="#FFFFFF"
for i in {0..15}; do
	curColor=$(echo "$LIST" |grep -P "\*color$i:" | grep -oP "#[A-Fa-f0-9]*")
	curDif=$(getDif $curColor)
	if (($curDif > $maxDif)) ; then
		maxDif=$curDif
		maxi=$i
		maxColor=$curColor
	fi
done

echo "$maxColor"

