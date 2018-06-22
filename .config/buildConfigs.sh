cd ~/DotFiles/.config

MODKEY="Mod4"
ALL=$(xrandr --listactivemonitors |grep -o -P "\ [A-Za-z]+[\w-]+"| sed "s/ //g")
LIST=(${ALL//$'\n'/ })
echo -e "set \$mod $MODKEY\nset \$primaryMonitor ${LIST[0]} \nset \$secondMonitor ${LIST[1]}\n $(cat i3/template)" > i3/config
cat polybar/template | sed "s/PLACEHOLDER_MONITOR/${LIST[0]}/g" > polybar/config
