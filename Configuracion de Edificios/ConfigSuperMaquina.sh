#!/bin/bash -ex
#Instalacion de Dependencias 
sudo apt-get install net-tools
sudo apt-get install iw wireless-tools
#sudo apt-get install hostapd
sudo apt-get install bridge-utils
#sudo apt-get install rfkill
#sudo apt-get install resolveconf
#sudo apt-get install iptables

#Creacion de Puentes de Conexion entre Switches
sudo brctl addbr puenteA_B
sudo brctl addbr puenteB_C
sudo brctl addbr puenteC_E
sudo brctl addbr puenteE_D

#Creacion de Puentes de Conexion para la Red Interna
sudo brctl addbr redInternaA
sudo brctl addbr redInternaB
sudo brctl addbr redInternaC
sudo brctl addbr redInternaE
sudo brctl addbr redInternaD

#Levantado de Puentes de Conexion entre Switches
sudo ip link set dev puenteA_B up
sudo ip link set dev puenteB_C up
sudo ip link set dev puenteC_E up
sudo ip link set dev puenteE_D up

#Levantado de Puentes de Conexion para la Red Interna
sudo ip link set dev redInternaA up
sudo ip link set dev redInternaB up
sudo ip link set dev redInternaC up
sudo ip link set dev redInternaE up
sudo ip link set dev redInternaD up


