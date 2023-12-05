#!/bin/bash

dpkg -s isc-dhcp-server &> /dev/null
if [ $? -eq 0 ]; then
echo "isc-dhcp-server is installed"
else
read -p 'Do you want to configure DHCPv4?: ' v4_choice
read -p 'Do you want to configure DHCPv6?: ' v6_choice
read -p 'Enter Ethernet Interface: ' eth_iface
sudo apt install -y isc-dhcp-server
sudo mv /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.bak
sudo touch /etc/default/isc-dhcp-server
sudo sh -c 'cat >> /etc/default/isc-dhcp-server << EOL
INTERFACESv4='$eth_iface'
INTERFACESv6='$eth_iface'
EOL'
echo "/etc/default/isc-dhcp-server"
cat /etc/default/isc-dhcp-server
printf "\n"

if [ $v4_choice == 'yes' ] || [ $v4_choice == 'y' ]
then
read -p 'Enter IPv4 Interface Network: ' iface_network
read -p 'Enter IPv4 Interface Subnet Mask: ' iface_subnet_mask
read -p 'Enter IPv4 dns: ' dns 
sudo mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak
sudo sh -c 'cat >> /etc/dhcp/dhcpd.conf << EOL
default-lease-time 600;
max-lease-time 7200;
authoritative;
option domain-name-servers '$dns';
#'$eth_iface'
subnet '$iface_network' netmask '$iface_subnet_mask' {
    ignore client-updates;
}

#subnet 192.168.111.0 netmask 255.255.255.0 {
    #range 192.168.111.10 192.168.111.20;
    #option routers 192.168.111.1;
#}
EOL'
echo "/etc/dhcp/dhcpd.conf"
cat /etc/dhcp/dhcpd.conf
printf "\n"
fi

if [ $v6_choice == 'yes' ] || [ $v6_choice == 'y' ]
then
read -p 'Enter IPv6 Interface Network/Mask: ' iface_network
read -p 'Enter IPv6 dns: ' dns6 
sudo mv /etc/dhcp/dhcpd6.conf /etc/dhcp/dhcpd6.conf.bak
sudo sh -c 'cat >> /etc/dhcp/dhcpd6.conf << EOL
default-lease-time 2592000;
preferred-lifetime 604800;
option dhcp-renewal-time 3600;
option dhcp-rebinding-time 7200;
allow leasequery;
option dhcp6.name-servers '$dns6';
option dhcp6.info-refresh-time 21600;
#'$eth_iface'
subnet6 '$iface_network' {
  ignore client-updates;
}

#subnet6 2a02:5761:1000:2::/64 {
  #range6 2a02:5761:1000:2::5 2a02:5761:1000:2::ff;
#}
EOL'
echo "/etc/dhcp/dhcpd6.conf"
cat /etc/dhcp/dhcpd6.conf
printf "\n"
fi

fi
