#This is just for learning purposes

#This lists info on all local network interfaces
ip addr show

#This gives you similar info along with packet info, so: more info, a bit more cost
ifconfig wlp3s0

#Example of `ip addr show` output, with some notes:

#  > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
#  >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#  >     inet 127.0.0.1/8 scope host lo
#  >        valid_lft forever preferred_lft forever
#  >     inet6 ::1/128 scope host 
#  >        valid_lft forever preferred_lft forever
#
#  loopback should be first entry. it enables network communication that's
#    completely local (like, to the motherboard).  obviously not necessary,
#    but a massive practical convenience, adds value to network
#    interfaces/infrastructure, and makes debugging/development feasible
#  the standard IP address for this is 127.0.0.1/8 AKA localhost
#    127.0.0.1/8 --> CIDR notation for a 127.0 network number and 0.1 host number
#
#  > 2: enp0s25: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
#  >     link/ether 50:7b:9d:6e:16:95 brd ff:ff:ff:ff:ff:ff
#
#  This is one way to get the MAC address.
#
#  > 3: wlp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
#  >     link/ether dc:53:60:d5:ff:7f brd ff:ff:ff:ff:ff:ff
#  >     inet 192.168.1.9/24 brd 192.168.1.255 scope global dynamic noprefixroute wlp3s0
#  >        valid_lft 55640sec preferred_lft 44840sec
#  >     inet6 fe80::de53:60ff:fed5:ff7f/64 scope link 
#  >        valid_lft forever preferred_lft forever
#  > 4: br-94f77057908c: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
#  >     link/ether 02:42:e1:ac:3a:33 brd ff:ff:ff:ff:ff:ff
#  >     inet 172.18.0.1/16 brd 172.18.255.255 scope global br-94f77057908c
#  >        valid_lft forever preferred_lft forever
#  > 5: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
#  >     link/ether 02:42:1b:24:41:a7 brd ff:ff:ff:ff:ff:ff
#  >     inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
#  >        valid_lft forever preferred_lft forever
#  > 6: br-c37910d52c31: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
#  >     link/ether 02:42:a4:9c:6a:0c brd ff:ff:ff:ff:ff:ff
#  >     inet 172.19.0.1/16 brd 172.19.255.255 scope global br-c37910d52c31
#  >        valid_lft forever preferred_lft forever


#Example of `ifconfig wlp3s0` output, with some notes:

# Similar info to ip addr show:
# > wlp3s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
# >         inet 192.168.1.9  netmask 255.255.255.0  broadcast 192.168.1.255
# >         inet6 fe80::de53:60ff:fed5:ff7f  prefixlen 64  scopeid 0x20<link>
# >         ether dc:53:60:d5:ff:7f  txqueuelen 1000  (Ethernet)
# RX (received packets), TX (transmitted packets)
# >         RX packets 10409416  bytes 10917485947 (10.1 GiB)
# >         RX errors 0  dropped 0  overruns 0  frame 0
# >         TX packets 5520818  bytes 969999237 (925.0 MiB)
# >         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
#
