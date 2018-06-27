cd ~/DotFiles/.config
cp polybar/template polybar/config
sed -i "s/PLACEHOLDER_ACCENT/$(bash getAccent.sh)/g" polybar/config
sed -i "s/PLACEHOLDER_MONITOR/$1/g" polybar/config
