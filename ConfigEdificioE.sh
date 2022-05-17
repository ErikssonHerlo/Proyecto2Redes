  GNU nano 5.4                                                         /etc/network/interfaces *                                                                 
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

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

#Configuracion de la Red Interna E para el Cliente
auto enp9s0
iface enp9s0 inet static
  address 10.10.43.1/28
  #Red Interna A
  post-up ip r replace 10.10.40.0/27 via 200.200.202.1
  pre-down ip r delete 10.10.40.0/27 via 200.200.202.1 || true
  #Red Interna B
  post-up ip r replace 10.10.41.0/28 via 200.200.202.1
  pre-down ip r delete 10.10.41.0/28 via 200.200.202.1 || true
  #Red Interna C
  post-up ip r replace 10.10.42.0/26 via 200.200.202.1
  pre-down ip r delete 10.10.42.0/26 via 200.200.202.1 || true
  #Red Interna D
  post-up ip r replace 10.10.44.0/26 via 200.200.204.2
  pre-down ip r delete 10.10.44.0/26 via 200.200.204.2 || true

