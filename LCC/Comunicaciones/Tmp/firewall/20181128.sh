#!/bin/bash

case $1 in
    start)

LAN=10.0.1.0/24
ADMIN=10.0.1.22
WWW=181.16.1.18
ILAN=eth0
IDMZ=eth1
INET=eth2
PROXY=181.16.1.19
I=/sbin/iptables

# Regla 1: Se puede acceder por SSH desde la PC de administración
$I -A INPUT -p tcp -s $ADMIN -i $ILAN --dport 22 -j ACCEPT

# Regla 1: No se permiten más accesos que los habilitados
$I -P INPUT DROP # P de policy osa por defecto

# Regla 2: DNS por udp
$I -A FORWARD -m iprange -s $LAN -i $ILAN --dst-range $WWW-$PROXY -p udp --dport 53 -j ACCEPT

# Regla 2: TCP a www 
$I -A FORWARD -m multiport -s $LAN -i $ILAN -d $WWW -p tcp --dport 53,80,443 -j ACCEPT

# Regla 2: TCP a proxy 
$I -A FORWARD -m multiport -s $LAN -i $ILAN -d $PROXY -p tcp --dport 53,3128 -j ACCEPT

# No se permiten mas accesos que los anteriores LAN->DMZ
# (REJECT en lugar de DROP para mejor diagnostico en la LAN)
$I -A FORWARD -i $ILAN -o $IDMZ -j REJECT

# Acceso de la LAN a Internet
# Regla 3.
# Ya no quedan mas destinos posibles que Internet y eso me permite simplificar.
$I -A FORWARD -m multiport -i $ILAN -p tcp --dports 80,443 -j REJECT
$I -A FORWARD -i $ILAN -s $LAN -j ACCEPT

# Regla 4
$I -A FORWARD -i $IDMZ -o $ILAN -d $LAN -j REJECT

$I -A FORWARD -m multiport -m iprange --src-range $WWW-$PROXY -i $IDMZ -o $INET -p tcp --dest-ports 53,80,443 -j ACCEPT
$I -A FORWARD -m iprange --src-range $WWW-$PROXY -i $IDMZ -o $INET -p udp --dest-ports 53 -j ACCEPT

# No mas accesos (recordar, puede ir en cualquier lugar)
$I -P FORWARD DROP

# Regla 5
$I -A FORWARD -m iprange -i $INET -o $IDMZ --dest-range $WWW-$PROXY -p tcp -dports 53 -j ACCEPT
$I -A FORWARD -m iprange -i $INET -o $IDMZ --dest-range $WWW-$PROXY -p udp -dports 53 -j ACCEPT

$I -A FORWARD -m multiport -i $INET -o $IDMZ -d $WWW -p tcp -dports 80,443 -j ACCEPT

# Si no tuviéramos restricciones de salida, no harían falta las reglas de
# estado tampoco.
$I -A OUTPUT -m state --state INVALID -j DROP
# La siguiente regla es necesaria para que funcione el ssh desde ADMIN
$I -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT


# Regla 6
$I -A OUTPUT -p tcp -d $PROXY --dport 3128 -j ACCEPT
$I -P OUTPUT DROP


# Tabla NAT
# Nateamos lo que viene de la DMZ y va a Internet
# (no se puede usar -i !)
$I -t nat -A POSTROUTING -o $INET -s $LAN -j SNAT --to 200.3.1.2


;;
stop)
$I -P INPUT ACCEPT
$I -P FORWARD DROP
$I -P OUTPUT ACCEPT
$I -F -t nat
$I -F
;;
*)
echo "Sintaxis: $0 <start|stop>"
exit 1
;;
esac