#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# X Resources

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Szerkeszto

export EDITOR="vim"
export PAGER=$EDITOR

# Monitorok

#xrandr --output HDMI2 --mode 1920x1080 --primary --output VGA1 --mode 1920x1080 --right-of HDMI2 --output HDMI1 --mode 1920x1080 --left-of HDMI2 &
xrandr --output HDMI2 --primary --output VGA1 --left-of HDMI2 --output HDMI1 --right-of HDMI2
# sleep .25


# i3

exec i3

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
