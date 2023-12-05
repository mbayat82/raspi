try:
    import netifaces as ni
    import sys
    from colorama import Fore, Back, Style
    from netaddr import IPAddress
except Exception as e:
    print (e)
    sys.exit()

ifaces = ni.interfaces()
for iface in ifaces:
    if 'lo' not in iface and 'veth' not in iface and 'docker' not in iface:
        print('------------------------------------------------------------')
        print ('Interface\t\t'+Fore.GREEN+iface,end='')
        print(Style.RESET_ALL)
        iface_ips = ni.ifaddresses(iface)
        if 17 in iface_ips:
            for i, addr in enumerate(iface_ips[17]):
                print('MAC Address\t\t'+iface_ips[17][i]['addr'])
        if 2 in iface_ips:
            for i, addr in enumerate(iface_ips[2]):
                mask = str(IPAddress(iface_ips[2][i]['netmask']).netmask_bits())
                print('IPv4 Address ('+str(i+1)+')\t'+Fore.CYAN+iface_ips[2][i]['addr']+'/'+mask,end='')
                print(Style.RESET_ALL)
        if 10 in iface_ips:
            for i, addr in enumerate(iface_ips[10]):
                mask = iface_ips[10][i]['netmask'].split('/')
                print('IPv6 Address ('+str(i+1)+')\t'+Fore.YELLOW+iface_ips[10][i]['addr']+'/'+mask[1],end='')
                print(Style.RESET_ALL)
print('------------------------------------------------------------')