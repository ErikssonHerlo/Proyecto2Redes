  GNU nano 5.4                                                         /etc/network/interfaces *                                                                 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

#source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

#Configuracion SSH
auto enp1s0
iface enp1s0 inet static
  address 192.168.122.29
  netmask 255.255.255.0
  gateway 192.168.122.1

#Configuracion de Bridge E_D desde el Edificio D (Receptor)
auto enp7s0
iface enp7s0 inet static
  address 200.200.204.2/30

  #Conexion Edificio D al Edificio C
  post-up ip r replace 200.200.202.0/30 via 200.200.204.1
  pre-down ip r delete 200.200.202.0/30 via 200.200.204.1 || true
  #conexion Edificio D al Edificio B
  post-up ip r replace 200.200.201.0/30 via 200.200.204.1
  pre-down ip r delete 200.200.201.0/30 via 200.200.204.1 || true
  #Conexion Edificio D al Edificio A
  post-up ip r replace 200.200.200.0/30 via 200.200.204.1
  pre-down ip r delete 200.200.200.0/30 via 200.200.204.1 || true

# The primary network interface
#allow-hotplug enp1s0
#iface enp1s0 inet dhcp

