#!/bin/bash

case $1 in
    start)

DMZ=181.16.1.16/28
SERV=10.0.2.0/24
LAN=10.0.1.0/24
ILAN=eth0
ISERV=eth1
IDMZ=eth2
INET=eth3
I=/sbin/iptables

# Estado
$I -A FORWARD -m state --state INVALID -j DROP
$I -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

$I -A FORWARD -i $ILAN -s $LAN -o $ISERV -d $SERV -j BLOCK
$I -A FORWARD -i $ILAN -s $LAN -j ACCEPT 

$I -A FORWARD -i $INET -m iprange  -o $IDMZ --dest-range 181.16.1.18-181.16.1.19 -p tcp --dport 53 -j ACCEPT
$I -A FORWARD -i $INET -m iprange -o $IDMZ --dest-range 181.16.1.18-181.16.1.19 -p udp --dport 53 -j ACCEPT
$I -A FORWARD -i $INET -m multiport -o $IDMZ -d 181.16.1.18 -p tcp -dport 80,443 -j ACCEPT

$I -A FORWARD -i $IDMZ -s $DMZ -o $INET -p tcp --dport 53 -j ACCEPT
$I -A FORWARD -i $IDMZ -s $DMZ -o $INET -p udp --dport 53 -j ACCEPT
$I -A FORWARD -i $IDMZ -s $DMZ -o $ISERV -d 10.0.2.3 -p tcp --dport 3306 -j ACCEPT

$I -P FORWARD DROP

$I -t NAT -A POSTROUTING -i $ILAN -s $LAN -o $INET -j SNAT -to 200.3.1.2
;;

stop)
    $I -F FORWARD
    $I -t nat -F POSTROUTING
;;

*)
    echo Error de Sintaxis
    exit 1
;;
esac