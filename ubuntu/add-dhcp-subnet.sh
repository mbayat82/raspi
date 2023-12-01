dpkg -s isc-dhcp-server &> /dev/null
if [ $? -eq 0 ]; then

read -p 'Do you want to add DHCPv4 subnet?: ' v4_choice
read -p 'Do you want to add DHCPv6 subnet?: ' v6_choice
if [ $v4_choice == 'yes' ] || [ $v4_choice == 'y' ]
then
read -p 'Enter IPv4 Network: ' network
read -p 'Enter IPv4 Subnet Mask: ' subnet_mask
read -p 'Enter IPv4 First IP: ' first_ip
read -p 'Enter IPv4 Last IP: ' last_ip
read -p 'Enter IPv4 Gateway: ' gateway
sudo sh -c 'cat << EOL >> /etc/dhcp/dhcpd.conf

subnet '$network' netmask '$subnet_mask' {
    range '$first_ip' '$last_ip';
    option routers '$gateway';
}
EOL'
sudo service isc-dhcp-server restart
fi

if [ $v6_choice == 'yes' ] || [ $v6_choice == 'y' ]
then
read -p 'Enter IPv6 Network/Mask: ' network6
read -p 'Enter IPv6 First IP: ' first_ip6
read -p 'Enter IPv6 Last IP: ' last_ip6
sudo sh -c 'cat << EOL >> /etc/dhcp/dhcpd6.conf

subnet6 '$network6' {
    range6 '$first_ip6' '$last_ip6';
}
EOL'
sudo service isc-dhcp-server6 restart
fi

else
echo "isc-dhcp-server is not installed"
fi

