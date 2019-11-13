#!/usr/bin/env bash

#A convenience script for setting up an ssh tunnel with a proxy jump without any
#config or using some newer methods that aren't available in older OpenSSH
#versions.

#I recommend doing this automatically with .ssh/config options and using the
#latest OpenSSH, but sometimes you're on a new machine and just want to launch
#the dang tunnel
proxy_user=jacob308
proxy_host=gateway.hpcc.msu.edu
dest_user=jacob308
dest_host=dev-intel14
local_ip=127.0.0.3
local_port=8686
dest_ip=127.0.0.1
dest_port=41375

echo "Starting tunnel ${local_ip}:${local_port} <--> ${dest_ip}:${dest_port}"
echo "    Proxy jumping through ${proxy_user}@${proxy_host}"
echo "    to host ${dest_user}@${dest_host}"
ssh -o ProxyCommand="ssh -W %h:%p ${proxy_user}@${proxy_host}" -L ${local_ip}:${local_port}:${dest_ip}:${dest_port} ${dest_user}@${dest_host} -N
