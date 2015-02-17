#!/bin/sh

gconftool-2 --set --type bool /apps/gnome-terminal/profiles/Default/use_system_font false
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Default/font "Ricty 13"
gconftool-2 --set --type bool /apps/gnome-terminal/profiles/Default/use_theme_colors false
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Default/background_color "#30A330A330A3"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Default/foreground_color "#EAFFEAFFEAFF"
gconftool-2 --set --type string /apps/gnome-terminal/profiles/Default/palette "#000000000000:#FFFF37773777:#4E4E9A9A0606:#C4C4A0A00000:#34346565A4A4:#DDF08443FFFF:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#FFFF83698369:#8A8AE2E23434:#FCFCE9E94F4F:#71E3CCEFDDDD:#EBCBB69CFFFF:#3434E2E2E2E2:#EEEEEEEEECEC"
gconftool-2 --set --type bool /apps/gnome-terminal/profiles/Default/silent_bell true
gconftool-2 --set --type int /apps/gnome-terminal/profiles/Default/scrollback_lines 2048
