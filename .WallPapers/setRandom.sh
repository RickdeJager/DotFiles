#!/bin/bash

cd "$(dirname "$0")"

dark=$(cat ~/DotFiles/.WallPapers/state)

if [ "$dark" -eq "1" ];then
	cd "DARK"
else
	cd "LIGHT"
fi

(wal -a 60 -i "$(ls |grep -E '*.png|*.jpg|*.jpeg' | shuf -n1)" &)
