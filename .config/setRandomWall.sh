~/DotFiles/.WallPapers/setRandom.sh 
MON=$(xrandr --listactivemonitors | grep 0: | grep -oP "\+\*[\w-]*" | sed "s/\+\*//")
sleep 0.5
~/DotFiles/.config/setPolyVars.sh $MON
~/DotFiles/.config/polybar/launch.sh &
