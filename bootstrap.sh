#!/usr/bin/env bash

# Grab LAN subnet for Puppet to use when building firewall rules
#echo "grabbin teh lan subnet"
#echo "FACTER_lansubnet=$(ip route | sed -n '2p' | awk '{print $1}')" >> /etc/environment
puppet module install puppetlabs-firewall

# cat > /etc/iptables.rules << EOL
# ########################################################################
# # filter table

# # Drop anything we aren't explicitly allowing. All outbound traffic is okay
# *filter
# :INPUT   DROP
# :FORWARD DROP
# :OUTPUT  ACCEPT

# # chain for all input on eth0
# :FW-eth0-INPUT -
# # chain for all input on tun0
# :FW-tun0-INPUT -

# ########################################################################
# # INPUT rules

# # Accept all on loopback interface
# -A INPUT -i lo -j ACCEPT

# # Accept ICMP packets needed for ping, traceroute, etc.
# -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
# -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
# -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT

# # Add custom INPUT filters
# -A INPUT -i eth0 -j FW-eth0-INPUT
# -A INPUT -i tun0 -j FW-tun0-INPUT

# ########################################################################
# # FW-eth0-INPUT rules

# # Accept connections from LAN
# -A FW-eth0-INPUT -s ${LAN_SUBNET} -j ACCEPT

# # Log anything on eth0 claiming it's from a local or non-routable network
# # https://oav.net/mirrors/cidr.html
# -A FW-eth0-INPUT -s 0.0.0.0/8          -j LOG --log-prefix "eth0-INPUT DROP LOCAL: "
# -A FW-eth0-INPUT -s 10.0.0.0/8         -j LOG --log-prefix "eth0-INPUT DROP A: "
# -A FW-eth0-INPUT -d 127.0.0.0/8        -j LOG --log-prefix "eth0-INPUT DROP LOOPBACK: "
# -A FW-eth0-INPUT -s 169.254.0.0/16     -j LOG --log-prefix "eth0-INPUT DROP LINK-LOCAL: "
# -A FW-eth0-INPUT -s 172.16.0.0/12      -j LOG --log-prefix "eth0-INPUT DROP B: "
# -A FW-eth0-INPUT -s 192.168.0.0/16     -j LOG --log-prefix "eth0-INPUT DROP C: "
# -A FW-eth0-INPUT -s 224.0.0.0/4        -j LOG --log-prefix "eth0-INPUT DROP MULTICAST D: "
# -A FW-eth0-INPUT -s 240.0.0.0/5        -j LOG --log-prefix "eth0-INPUT DROP E: "
# -A FW-eth0-INPUT -s 240.0.0.0/4        -j LOG --log-prefix "eth0-INPUT DROP FUTURE: "
# -A FW-eth0-INPUT -s 248.0.0.0/5        -j LOG --log-prefix "eth0-INPUT DROP RESERVED: "
# -A FW-eth0-INPUT -s 255.255.255.255/32 -j LOG --log-prefix "eth0-INPUT DROP BROADCAST: "

# # Accept any established connections
# -A FW-eth0-INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# # Log and drop everything else
# -A FW-eth0-INPUT -j LOG --log-prefix "eth0-INPUT DROP: "

# ########################################################################
# # FW-tun0-INPUT rules

# # Accept any established connections
# -A FW-tun0-INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# # Log and drop anything else
# -A FW-tun0-INPUT -j LOG --log-prefix "tun0-INPUT DROP: "

# COMMIT
# EOL

# # load iptables rules
# iptables-restore < /etc/iptables.rules

