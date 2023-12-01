#!/bin/bash
sudo echo "caching sudo password"
sudo apt update
sudo apt -y install net-tools nmap network-manager speedtest-cli
sudo apt -y install telnet telnetd ser2net
sudo apt -y install links2 neofetch btop gdu bat exa ripgrep tmux
sudo apt -y install python3 python3-pip
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git
pip3 install pipenv --break-system-packages
pip3 install netifaces --break-system-packages
pip3 install colorama --break-system-packages
# Alias
sh -c 'cat << EOL >> ~/.bashrc

alias bat="batcat"
alias more="batcat -p
alias cat="batcat -p --pager=never"
alias top="btop"
alias system="neofetch"
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"
alias showip="python3 ~/raspi/showip.py"
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
# SSH
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
sh -c '$SHELL'
