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

#Allow exiting DE/WM using CTRL+ALT+BKSP
setxkbmap -option terminate:ctrl_alt_bksp

# Set a default DE/WM
session=${1:-cinnamon}

case $session in
    cinnamon        ) exec cinnamon-session;;
    cinnamon2d      ) exec cinnamon-session-cinnamon2d;;
    gnome           ) exec gnome-session;;
    gnome-classic   ) exec gnome-session --session=gnome-classic;;
    kde             ) exec startkde;;
    xfce4           ) exec startxfce4;;
    mate            ) exec mate-session;;
    # No known session, try to run it as command
    *               ) exec $1;;
esac
