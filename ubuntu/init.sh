#!/bin/bash
sudo echo "caching sudo password"
sudo apt update
sudo apt -y install net-tools nmap network-manager speedtest-cli
sudo apt -y install telnet telnetd ser2net
sudo apt -y install links2 neofetch btop gdu bat exa ripgrep fzf tmux
sudo apt -y install python3 python3-pip
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
pip3 install pipenv
pip3 install netifaces
pip3 install colorama
# Serial to Network
sudo sh -c "mv /etc/ser2net.yaml /etc/ser2net.yaml.bak"
sudo touch /etc/ser2net.yaml
sudo sh -c "cat >> /etc/ser2net.yaml" << EOL
%YAML 1.1
---
default:
  name: kickolduser
  value: true
default:
  name: speed
  value: 9600n81
connection: &con2001
  accepter: tcp,2001
  timeout: 120
  enable: on
  connector: serialdev,/dev/ttyUSB0
EOL
# Aliases
sh -c 'cat << EOL >> ~/.bashrc

alias bat="batcat"
alias more="batcat -p"
alias cat="batcat -p --pager=never"
alias top="btop"
alias system="neofetch && showip"
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"
alias showip="python3 ~/raspi/showip.py"
EOL'
# WiFi Connecitivity
read -sp 'PiFi SSID password: ' pifi_password
sudo nmcli con add type wifi ifname wlan0 con-name PiFiHotspot autoconnect yes ssid PiFi
sudo nmcli con modify PiFiHotspot 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
sudo nmcli con modify PiFiHotspot wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify PiFiHotspot wifi-sec.psk $pifi_password
sudo nmcli con modify PiFiHotspot conn.autoconnect-p 10
# Static IP
sudo mv /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak
sudo touch /etc/netplan/50-cloud-init.yaml
sudo sh -c "cat >> /etc/netplan/50-cloud-init.yaml" << EOL
network:
  version: 2
  wifis:
    renderer: NetworkManager
  ethernets:
    eth0:
      dhcp4: no
      dhcp6: no
      addresses:
        - 192.168.0.100/24
        - 2001::100/64
      routes:
      #- to: default
      #  via: 192.168.0.1
      - to: "::/0"
        via: 2001::1/64
        on-link: true
EOL
# SSH
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
sh -c '$SHELL'