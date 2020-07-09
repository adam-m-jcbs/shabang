#!/usr/bin/sh

#Requirements:
#   TODO: Add if needed

#Pixel keyboard shortcuts, emulated with xmodmap

#Customize keymappings for the pixel-c keyboard
#   ... key            --> keycode 108 Alt_R
#   <search/mag glass> --> keycode 133 Super_L

#turn ... into distinct mod key, we use Mode_switch here
#                         key         shift+key   Mode_switch+key Mode_switch+shift+key
xmodmap -e "keycode 108 = Mode_switch Mode_switch Mode_switch     Mode_switch"

#... + o (keycode 32)        --> [   (keycode 34 bracketleft)
#... + shift + o (keycode 32) --> {   (keycode 34 braceleft)
xmodmap -e "keycode 32 = o O bracketleft braceleft"

#... + p (keycode 33)         --> ]   (keycode 35 bracketright)
#... + shift + p (keycode 33) --> }   (keycode 35 braceright)
xmodmap -e "keycode 33 = p P bracketright braceright"

#... + = (keycode 21)         --> \   (keycode 51 backslash)
#... + shift + = (keycode 21) --> |   (keycode 51 bar)
xmodmap -e "keycode 21 = equal plus backslash bar"

#... + 2 (keycode 11)         --> `   (keycode 49 grave)
#... + shift + 2 (keycode 11) --> ~   (keycode 49 asciitilde)
xmodmap -e "keycode 11 = 2 at grave asciitilde"

#... + 1 (keycode 10)         --> Esc (keycode 34)
xmodmap -e "keycode 10 = 1 exclam Escape NoSymbol"


