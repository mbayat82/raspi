try:
    import netifaces as ni
    import sys
    from netaddr import IPAddress
    from rich.console import Console
    from rich.table import Table
    from rich import box
except Exception as e:
    print (e)
    sys.exit()

ifaces = ni.interfaces()
console = Console()
table = Table(show_header=True, box=box.SIMPLE_HEAD, header_style="bold magenta")
table.add_column("Interface")
table.add_column("MAC Address")
table.add_column("IPv4 Address")
table.add_column("IPv6 Address")
for iface in ifaces:
    mac = ""
    ipv6 = ""
    ipv4 = ""
    if 'lo' not in iface and 'veth' not in iface and 'docker' not in iface:
        iface_ips = ni.ifaddresses(iface)
        if 17 in iface_ips:
            for i, addr in enumerate(iface_ips[17]):
                mac = iface_ips[17][i]['addr']
        if 2 in iface_ips:
            for i, addr in enumerate(iface_ips[2]):
                mask = str(IPAddress(iface_ips[2][i]['netmask']).netmask_bits())
                ipv4 = ipv4 + iface_ips[2][i]['addr'] + '\n'
        if 10 in iface_ips:
            for i, addr in enumerate(iface_ips[10]):
                mask = iface_ips[10][i]['netmask'].split('/')
                ipv6 = ipv6 + iface_ips[10][i]['addr'] + '\n'
        table.add_row(iface,mac,ipv4,ipv6)
console.print(table)