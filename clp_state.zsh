#!/bin/zsh

#convenience script for my clocking/logging system
echo `cat ~/.clock_log/state | awk '{$1=$1;print}'`
