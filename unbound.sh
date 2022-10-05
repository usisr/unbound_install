#!/bin/sh

echo "Adresse ip du server"
read -r interface

echo "masque du réseau"
read -r mask_reseau

echo "Adresse réseau"
read -r addr_reseau


#Install unbound 
if ! [ -x "$(dpkg -l | grep unbound)"]; then
  apt install unbound -y
fi
cp unbound.conf /etc/unbound/unbound.conf

sed 's/INT/'"$interface"'/g' /etc/unbound/unbound.conf

sed 's/ADDRR/'"$addr_reseau"'/g' /etc/unbound/unbound.conf

sed 's/MASK/'"$mask_reseau"'/g' /etc/unbound/unbound.conf

chown unbound:unbound -R /var/lib/unbound/
touch /var/lib/unbound.log
chown unbound:unbound -R /var/lib/unbound.log
echo "nameserver 127.0.0.1" >> /etc/resolv.conf
