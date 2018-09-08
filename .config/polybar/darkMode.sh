#!/bin/bash

toggle() {
	dark=$(((dark + 1) % 2))
	echo $dark > ~/DotFiles/.WallPapers/state
	~/DotFiles/.config/setRandomWall.sh
}

getState() {
	dark=$(cat ~/DotFiles/.WallPapers/state)
}

display() {
	if [ "$dark" -eq "1" ]; then
		echo ''
	else
		echo ''
	fi
}
getState
if [ "$1" == "toggle" ]; then
	toggle
fi
display
