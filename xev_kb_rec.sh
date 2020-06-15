#!/usr/bin/sh

#Use xev to monitor/echo key presses and the keycodes associated with them
xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
