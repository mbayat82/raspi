# adding temp ip address
sudo ip addr add 192.168.1.101/24 dev eth0
sudo ip -6 addr add 2a02:5761:1000:100::1/64 dev eth0

# adding temp route
sudo ip route add 10.10.10.0/0 via 192.168.0.1 dev eth0
ip route list
sudo ip -6 route add default via 2001::1 dev eth0
ip -6 route list

# using bat
--show-all          <!-- shows all none printable characters -->
--theme Nord -p     <!-- -p for plain -->

# make executable
chmod +x test.sh

# screen
screen -S test          <!-- create a session -->
Ctrl+a d                <!-- deattach from session -->
screen -ls              <!-- list screens -->
screen -r 1             <!-- reattach to session -->
screen -X -S 1 kill     <!-- kill session 1 -->

# completely remove package
sudo apt-get purge --auto-remove isc-dhcp-server

# vim
'gg'            <!-- first line -->
'G'             <!-- last line -->
'dG'            <!-- delete until last line -->
'dd'            <!-- delete current line -->
'0'             <!-- beginning of line -->
'$'             <!-- end of line -->
'%d'            <!-- delete all -->
'+15'           <!-- start from -->
'yy'            <!-- copy line -->
'y$'            <!-- copy until end of line -->
'p'             <!-- paste -->
':set number'

# utilities
rg          <!-- ripgrep -->
fzf         <!-- fzf ↵ -->
tree        <!-- exa --tree -->
tree -l     <!-- exa -T -l -->
ls          <!-- exa -->
ll          <!-- exa -l -->
system      <!-- neofetch -->
top         <!-- btop -->
gdu         <!-- graphical disk usage -->

# nmcli
sudo nmcli con show
sudo nmcli con down WiFi
sudo nmcli con up WiFi
sudo nmcli con delete WiFi
nmcli dev wifi

# nmap
-sV             <!-- show all services detail and version -->
-sP             <!-- only ping -->
-sS             <!-- TYP SYN -->
-PR             <!-- ARP discovery -->
-n              <!-- no resolve -->
10.0.0.1-5      <!-- scan from 10.0.0.1 to 10.0.0.5 -->
10.0.0.0/24     <!-- scan the whole subnet -->
--exclude       <!-- exclude following IP address -->
-T5             <!-- time templates, from T0 to T5, T5 is the fastest, T3 is the default -->

# df (disk free)
-h              <!-- human readable -->
-T              <!-- storage type -->
-x  tmpfs       <!-- exclude tmpfs -->

# du (disk usage)
du /home/root       <!-- disk usage of a directory, current directory is the default -->
-h                  <!-- human readable -->
--max-depth 2       <!-- only two sub-directories deep -->
-s                  <!-- summary -->
-c /home/root/*     <!-- total -->

# leading commands
time            <!-- time to excute a command or a script -->
watch           <!-- auto refresh -->

# tmux
tmux                <!-- start a tmux new session -->
^b                  <!-- leader, Cntrl-b -->
^b %                <!-- split vertically -->
^b "                <!-- split horizontally -->
^b <arrow>          <!-- move between splits -->
^b <space>          <!-- change layout -->
^b c                <!-- new window -->
^b n                <!-- next window -->
^b :                <!-- command mode -->
^b :rename-window   <!-- give window a name -->
^b :rename-session  <!-- give session a name -->
^b d                <!-- deattach -->
tmux list-sessions
tmux attach         <!-- if only tmux, it will create a new session -->
^b s                <!-- show sessions within tmux -->
^b w                <!-- show sessons and windows -->
~/.tmux.conf        <!-- tmux config file -->
 set -g prefix C-s  <!-- make Ctrl-s the leader -->
^b :source ~./tmux.conf