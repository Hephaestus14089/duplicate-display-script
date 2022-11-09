#!/usr/bin/env bash

## Toggle on/off an external HDMI monitor
## Does not support audio over HDMI as it pretends to be DVI

intern="eDP-1"
extern="HDMI-1"

case "$1" in
	"disconnect")
		xrandr --output "$extern" --off --output "$intern" --auto
		;;
	"connect")
		xrandr --output "$extern" --set audio force-dvi --mode 1440x900\
		&&\
		xrandr --newmode "1440x900_60.00"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync\
		&&\
		xrandr --addmode "$intern" 1440x900_60.00\
		&&\
		xrandr --output "$intern" --mode 1440x900 --output "$extern" --same-as "$intern"\
		&&\
		nitrogen --restore &\
		;;
	"reconnect")
		xrandr --output "$extern" --set audio force-dvi --mode 1440x900\
		&&\
		xrandr --output "$intern" --mode 1440x900 --output "$extern" --same-as "$intern"\
		&&\
		nitrogen --restore &\
		;;
esac
