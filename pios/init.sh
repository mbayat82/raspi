#!/bin/bash
sudo echo "caching sudo password"
sudo apt update
sudo apt -y upgrade
sudo apt -y install net-tools nmap network-manager speedtest-cli dnsutils tcpdump
sudo apt -y install telnet telnetd ser2net
sudo apt -y install links2 neofetch btop gdu bat exa ripgrep tmux vim
sudo apt -y install python3 python3-pip
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
pip3 install pipenv --break-system-packages
pip3 install netifaces --break-system-packages
pip3 install netaddr --break-system-packages
pip3 install colorama --break-system-packages
pip3 install rich --break-system-packages
# Alias
sh -c 'cat << EOL >> ~/.bashrc

alias bat="batcat"
alias more="batcat -p"
alias cat="batcat -p --pager=never"
alias top="btop"
alias system="neofetch && showip"
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"
alias showip="python3 ~/raspi/showip2.py"
EOL'
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
# WiFi Connecitivity
read -sp 'PiFi SSID password: ' pifi_password
sudo nmcli con add type wifi ifname wlan0 con-name PiFiHotspot autoconnect yes ssid PiFi
sudo nmcli con modify PiFiHotspot 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
sudo nmcli con modify PiFiHotspot wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify PiFiHotspot wifi-sec.psk $pifi_password
sudo nmcli con modify PiFiHotspot conn.autoconnect-p 10
# Modify Preconfigured WiFi priority
sudo nmcli con modify preconfigured connection.autoconnect-priority 100
# SSH
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBoNb6mR9UVfUCemxKCP1874fEeaRVs+KEmY6v5Cks7W4EJOi83RdHT+xpkdzlCf3NUhsPThORvA2P8hdBfiOH+FT25LGhyiK+l6wyaqv55QZfrUSuigcJjfaq7LBfkNtKQSmcKCkYYJTUSV7bIsTbmgbFgcCsUZ2H5tIpKF/a7DozWkYFH/Rx+vQjcOB/AKqB1yTWKN/i0t9vYoS6VoOq1IP4BX6BGv4+HqSgKjGJCPQ9ERpe4Bw5WlTQqNxOdnfQRFdh5OXxYm9lKkKdTMWXPHkWvyHJCBU+nmqCe4/izwyFFzHsNVlynrRJS2a1yH9TUXzXOoqYHB8ELmUqG7xkZQUeZ0Twaak6G0sJ/wNAl2P/HAV+RK3mjFMd4dXHNVqcupg/4RGmIXOxNpBpqNcPo6tIPNLUvvyYw7fG5rStABJGAw2nJXtO4pNJ0Suh6Dq9NnEnxIphsS6NvFI/9b7AE4Jc53gfc7QnSpSxZWh60OXPiUCu+dJK32QtHLcEM7k= xbaya@Whitey' >> ~/.ssh/authorized_keys
sudo raspi-config
sh -c '$SHELL'
