try:
    import netifaces as ni
    import sys
    from colorama import Fore, Back, Style
except:
    print ('library not installed')
    sys.exit()

ifaces = ni.interfaces()
for iface in ifaces:
    if 'lo' not in iface and 'veth' not in iface and 'docker' not in iface:
        print('------------------------------------------------------------')
        print ('Interface\t\t'+Fore.GREEN+iface,end='')
        print(Style.RESET_ALL)
        iface_ips = ip = ni.ifaddresses(iface)
        if 17 in iface_ips:
            for i, addr in enumerate(iface_ips[17]):
                print('MAC Address\t\t'+iface_ips[17][i]['addr'])
        if 2 in iface_ips:
            for i, addr in enumerate(iface_ips[2]):
                print('IPv4 Address ('+str(i+1)+')\t'+Fore.CYAN+iface_ips[2][i]['addr'],end='')
                print(Style.RESET_ALL)
        if 10 in iface_ips:
            for i, addr in enumerate(iface_ips[10]):
                print('IPv6 Address ('+str(i+1)+')\t'+Fore.YELLOW+iface_ips[10][i]['addr'],end='')
                print(Style.RESET_ALL)
print('------------------------------------------------------------')