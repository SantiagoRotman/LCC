DMZ=10.1.1.0/29
SERV=10.10.0.0/22
LAN=10.23.0.0/16
ILAN=eth2
ISERV=eth1
IDMZ=eth3
INET=eth0
I=/sbin/iptables

$I -A FORWARD -m state --state INVALID -j DROP
$I -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

$I -P FORWARD DROP

$I -A FORWARD -m multiport -i $ILAN -o $ISERV -s $LAN -d 10.10.1.3 -p TCP -dports ... -j ACCEPT
$I -A FORWARD -i $ILAN -o $ISERV -s $LAN -d dbserver -p TCP -dport 443 -j ACCEPT
$I -A FORWARD -i $ILAN -o $IDMZ -s $LAN -d $relay -p TCP -dport 53 -j ACCEPT
$I -A FORWARD -i $ILAN -o $IDMZ -s $LAN -d $relay -p udp -dport 53 -j ACCEPT


#2
$I -A FORWARD -m multiport -i $ISERV -o $IDMZ -s $mailserver -d $relay -p TCP -dports 53,465 -j ACCEPT
$I -A FORWARD -i $ISERV -o $IDMZ -s $mailserver -d $relay -p udp -dport 53 -j ACCEPT


#3
$I -A FORWARD -i $IDMZ -o $ISERV -s $relay -d $mailserver -p tcp -dport 465 -j ACCEPT

#4
...

#5
$I -A FORWARD -i $ILAN -o $INET -s $LAN -j ACCEPT

#6
$I -A FORWARD -i $INET -d

#7

#8
$I -A INPUT -i $ILAN -s $admin -p tcp 22 -j ACCEPT
$I -A INPUT -j DROP
$I -A OUTPUT -o $IDMZ -d $relay -p tcp/udp 53 -j ACCEPT
$I -A OUTPUT -j DROP

#NAT
$I -t nat -A POSTROUTING -s $LAN -o $IF_EXT -j SNAT -to $IP_EXT
$I -t nat -A POSTROUTING -i $IDMZ -o $INET -j SNAT -to $ipPublica 

$I -t nat -A PREROUTING -i $INET -o $IDMZ -d $IP_EXT -m multiport -p tcp 53,25 -j DNAT -to $relay 
$I -t nat -A PREROUTING -i $INET -o $IDMZ -d $IP_EXT -p udp 53 -j DNAT -to $relay 
$I -t nat -A PREROUTING -i $INET -o $IDMZ -d $IP_EXT -m multiport -p tcp 80,443 -j DNAT -to $webserver