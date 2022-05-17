  GNU nano 5.4                                                         /etc/network/interfaces *                                                                 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

#source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

#Configuracion de SSH
auto enp1s0
iface enp1s0 inet static
  address 192.168.122.25
  netmask 255.255.255.0
  gateway 192.168.122.1

#Configuracion de Bridge A_B desde el Edificio A (Emisor)
auto enp7s0
iface enp7s0 inet static
  address 200.200.200.1/30

#Configuracion desde el Edificio A (Emisor)
#Conexion del Edificio A al Edificio C
  post-up ip r replace 200.200.201.0/30 via 200.200.200.2
  pre-down ip r delete 200.200.201.0/30 via 200.200.200.2 || true
#Conexion del Edificio A al Edificio E
  post-up ip r replace 200.200.202.0/30 via 200.200.200.2
  pre-down ip r delete 200.200.202.0/30 via 200.200.200.2 || true
#Conexion del Edificio A al Edificio D
  post-up ip r replace 200.200.204.0/30 via 200.200.200.2
  pre-down ip r delete 200.200.204.0/30 via 200.200.200.2 || true

# The primary network interface
#allow-hotplug enp1s0
#iface enp1s0 inet dhcp



