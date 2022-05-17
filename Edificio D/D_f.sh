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
  address 10.10.44.3/26
  #Conexion hacia la Red Interna C
  post-up ip r replace 10.10.42.0/26 via  10.10.44.1
  pre-down ip r delete 10.10.42.0/26 via  10.10.44.1
EOF

systemctl restart networking
ip -c a
