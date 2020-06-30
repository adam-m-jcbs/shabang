#!/usr/bin/sh

#Requirements:
#   You need `xev`, which on Arch is
#   $ pacman -Syu xorg-xev
#
#   Most *nixes should come with awk

#Use xev to monitor/echo key presses and the keycodes associated with them
#This incantation is originally from the Arch Wiki.
xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
