#!/bin/sh
echo "Adresse ip du server"
read -r interface

echo "masque du réseau"
read -r mask_reseau

echo "Adresse réseau"
read -r addr-reseau


#Cherche si curl est installer
if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using apt (Debian and derivatives) or yum/dnf (CentOS)"
  exit 1
fi

#Install unbound 
if ! [ -x "$(dpkg -l | grep unbound)"]; then
  apt install unbound -y
fi

sed 's/INT/$interface/g' /etc/unbound/unbound.conf

sed 's/ADDRR/mask_reseau/g' /etc/unbound/unbound.conf

sed 's/MASK/$addr-reseau/g' /etc/unbound/unbound.conf

chown unbound:unbound -R /var/lib/unbound/
touch /var/lib/unbound.log
chown unbound:unbound -R /var/lib/unbound.log
echo "nameserver 127.0.0.1" > /etc/resolv.conf