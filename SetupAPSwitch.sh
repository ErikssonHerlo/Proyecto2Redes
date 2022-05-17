#!/bin/bash
#Instalacion de Dependencias 
sudo apt-get install -y hostapd dnsmasq wireless-tools iw wvdial
# Solucion para: ifconfig: command not found
sudo apt-get install net-tools -y
#Paquete de instalacion para filtrar paquetes de red
sudo apt-get install iptables

#Paquetes de instalacion para nmcli & rfkill
sudo apt-get install network-manager
sudo apt-get install rfkill

#Desbloquear Wifi
sudo rfkill list all
sudo rfkill unblock wifi
sudo nmcli radio wifi off

#Configuracion de Interfaces
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto enp1s0
iface enp1s0 inet manual

iface wlp2s0 inet manual
EOF

#Path de Configuracion hostapd
sed -i 's#^DAEMON_CONF=.*#DAEMON_CONF=/etc/hostapd/hostapd.conf#' /etc/init.d/hostapd

#Configurar valores de dnsmasq para el servicio DHCP
cat <<EOF > /etc/dnsmasq.conf
log-facility=/var/log/dnsmasq.log
interface=wlp2s0
dhcp-range=10.10.20.3,10.10.20.250,12h
dhcp-option=3,10.10.20.3
dhcp-option=6,10.10.20.3
log-queries
EOF

#Iniciar servicio dnsmasq
sudo service dnsmasq start

#Bajar la interfaz
sudo ifconfig wlp2s0 down

#Levantar la interfaz wifi con la ip:
sudo ifconfig wlp2s0 10.10.20.3/24 up

#Configuracion del servicio de internet
sudo iptables -t nat -F
sudo iptables -F
sudo iptables -t nat -A POSTROUTING -o enp1s0 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlp2s0 -o enp1s0 -j ACCEPT
echo '1' > /proc/sys/net/ipv4/ip_forward

#Configuracion del archivo hostapd, para el AccesPoint
cat <<EOF > /etc/hostapd/hostapd.conf
interface=wlp2s0
driver=nl80211
channel=3
ssid=AP_Switch
wpa=2
wpa_passphrase=1234567890
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
# Change the broadcasted/multicasted keys after this many seconds.
wpa_group_rekey=600
# Change the master key after this many seconds. Master key is used as a basis
wpa_gmk_rekey=86400
EOF

#Desenmascarar el servicio hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd

#Inicializar servicio hostapd
sudo service hostapd start

#Visualizar Estado de los Servicios hostapd y dnsmasq
systemctl status service hostapd
systemctl status service dnsmasq