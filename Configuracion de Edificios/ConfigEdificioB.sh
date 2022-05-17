  GNU nano 5.4                                                         /etc/network/interfaces *                                                                 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

#Configuracion de SSH
auto enp1s0
iface enp1s0 inet static
  address 192.168.122.26
  netmask 255.255.255.0
  gateway 192.168.122.1

#Modo Receptor
#Configuracion de Bridge A_B desde el Edificio B (Receptor)
auto enp7s0
iface enp7s0 inet static
  address 200.200.200.2/30

#Modo Emisor
#Configuracion de Bridge B_C desde el Edificio B (Emisor)
auto enp8s0
iface enp8s0 inet static
  address 200.200.201.1/30

#Conexion Edificio B al Edificio E
  post-up ip r replace 200.200.202.0/30 via 200.200.201.2
  pre-down ip r delete 200.200.202.0/30 via 200.200.201.2 || true
#Conexion del Edificio B al Edificio D
  post-up ip r replace 200.200.204.0/30 via 200.200.201.2
  pre-down ip r delete 200.200.204.0/30 via 200.200.201.2 || true

#Configuracion de la Red Interna B para el Cliente
auto enp9s0
iface enp9s0 inet static
  address 10.10.41.1/28
  #Red Interna A
  post-up ip r replace 10.10.40.0/27 via 200.200.200.1
  pre-down ip r delete 10.10.40.0/27 via 200.200.200.1 || true
  #Red Interna C
  post-up ip r replace 10.10.42.0/26 via 200.200.201.1
  pre-down ip r delete 10.10.42.0/26 via 200.200.201.1 || true
  #Red Interna E
  post-up ip r replace 10.10.43.0/28 via 200.200.201.2
  pre-down ip r delete 10.10.43.0/28 via 200.200.201.2 || true
