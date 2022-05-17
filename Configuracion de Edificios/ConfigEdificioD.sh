  GNU nano 5.4                                                         /etc/network/interfaces *                                                                 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

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

#Configuracion de la Red Interna D para el Cliente
auto enp8s0
iface enp8s0 inet static
  address 10.10.44.1/28
  #Red Interna E
  post-up ip r replace 10.10.43.0/28 via 200.200.204.1
  pre-down ip r delete 10.10.43.0/28 via 200.200.204.1 || true
  #Red Interna C
  post-up ip r replace 10.10.42.0/26 via 200.200.204.1
  pre-down ip r delete 10.10.42.0/26 via 200.200.204.1 || true
