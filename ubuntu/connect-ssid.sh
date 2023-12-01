nmcli dev wifi
read -p 'Connection Name: ' con_name
read -p 'SSID: ' wifi_ssid
read -sp 'Password: ' wifi_password
read -p 'Priority: ' priority
sudo nmcli con add con-name $con_name ifname wlan0 type wifi ssid \'$wifi_ssid\'
sudo nmcli con modify $con_name wifi-sec.key-mgmt wpa-psk
sudo nmcli con modify $con_name wifi-sec.psk \'$wifi_password\'
sudo nmcli con modify $con_name conn.autoconnect-priority $priority
sudo nmcli con modify $con_name autoconnect yes
sudo nmcli con up $con_name