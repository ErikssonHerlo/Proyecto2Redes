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
  netmask 25200.200.1/30
#Configuracion desde el Edificio A (Emisor)
#Conexion del Edificio A al Edificio C
  post-up ip r replace 200.200.201.0/30 via 200.200.200.2
  pre-down ip r delete 200.200.201.0/30 via 200.200.200.2 || true
#Conexion del Edificio A al Edificio E
  post-up ip r replace 200.200.202.0/30 via 205.255.255.0
  gateway 192.168.122.1

#Configuracion del Cliente
auto enp7s0
iface  enp7s0 inet static
  address 10.10.41.4/28
  #Conexion hacia la Red Interna E
  post-up ip r replace 10.10.43.0/28 via  10.10.41.1
  pre-down ip r delete 10.10.43.0/28 via  10.10.41.1
EOF

systemctl restart networking
ip -c a
