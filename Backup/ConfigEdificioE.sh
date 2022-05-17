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
  address 192.168.122.28
  netmask 255.255.255.0
  gateway 192.168.122.1

#Configuracion de Bridge C_E  desde el Edificio E (Receptor)
auto enp7s0
iface enp7s0 inet static
  address 200.200.202.2/30

  #Conexion de Edificio E al Edificio B
  post-up ip r replace 200.200.201.0/30 via 200.200.202.1
  post-up ip r replace 200.200.201.0/30 via 200.200.202.1 || true
  #Conexion de Edificio E al Edificio A
  post-up ip r replace 200.200.200.0/30 via 200.200.202.1
  post-up ip r replace 200.200.200.0/30 via 200.200.202.1 || true

#Configuracion de Bridge E_D desde el Edificio E (Emisor)
auto enp8s0
iface enp8s0 inet static
  address 200.200.204.1/30

# The primary network interface
#allow-hotplug enp1s0
#iface enp1s0 inet dhcp
