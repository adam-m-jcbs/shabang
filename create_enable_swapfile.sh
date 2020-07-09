#!/usr/bin/sh

#Requirements:
#   TODO: Add if needed

#Add a swapfile with basic linux utilities, as per arch wiki

#Use `dd` to create a 2048 MB swapfile at `/swapfile`
dd if=/dev/zero of=/swapfile bs=1M count=512 status=progress

#Make sure only root/system can read swapfile
chmod 600 /swapfile

#`mkswap` script is provided in Arch, maybe not others?
mkswap /swapfile

#Turn it on, again using a script that's provided in Arch
swapon /swapfile

#You'll need to mount it to keep it persistent!
#Here's an example of mounting it with fstab file:
#
#/etc/fstab
#---
#/swapfile none swap defaults 0 0
