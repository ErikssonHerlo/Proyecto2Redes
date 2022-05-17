#!/bin/bash -ex

#Configuracion del Cliente
cat <<EOF > /etc/network/interfaces
# The loopback network interface
auto lo
iface lo inet loopback

#Configuracion de SSH
auto enp1s0
iface enp1s0 inet static
  address 192.168.122.30
  netmask 255.255.255.0
  gateway 192.168.122.1

#Configuracion del Cliente
auto enp7s0
iface  enp7s0 inet static
  address 10.10.41.2/28
  #Conexion hacia la Red Interna A
  post-up ip r replace 10.10.40.0/27 via  10.10.41.1
  pre-down ip r delete 10.10.40.0/27 via  10.10.41.1
EOF

systemctl restart networking
ip -c a
