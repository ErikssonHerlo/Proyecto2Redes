#!/bin/bash
value=$(($1+1))
echo "
auto enp1s0
iface  enp1s0 inet static
  address 10.10.71.$value/27
#Lan A
  post-up ip r replace 10.10.70.0/27 via  10.10.71.1
  pre-down ip r delete 10.10.70.0/27 via  10.10.71.1
#Lan C
  post-up ip r replace 10.10.72.0/27 via  10.10.71.1
  pre-down ip r delete 10.10.72.0/27 via  10.10.71.1
#Lan E
  post-up ip r replace 10.10.73.0/29 via  10.10.71.1
  pre-down ip r delete 10.10.73.0/29 via  10.10.71.1
#Lan D
  post-up ip r replace 10.10.74.0/27 via  10.10.71.1
  pre-down ip r delete 10.10.74.0/27 via  10.10.71.1


auto enp7s0
iface  enp7s0 inet static
  address 192.168.122.120/24
" > /etc/network/interfaces

systemctl restart networking



