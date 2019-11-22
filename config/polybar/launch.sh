#!/bin/sh
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep .5; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        t=none
        if [ "$m" == "HDMI2" ] || [ "$m" == "LVDS1" ]; then
            t=right
        fi
        MONITOR=$m TRAY=$t polybar --reload top &
    done
else
    polybar --reload top &
fi
