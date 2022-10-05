#!/bin/bash

#Install unbound 
if  [ -x "$(dpkg -l | grep unbound)"]; then
  apt remove unbound -y
  apt purge unbound -y
fi
sed 's/nameserver 127.0.0.1/ /g' /etc/resolv.conf
