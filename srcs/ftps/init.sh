#!/bin/sh

MINIKUBE_IP_ADDRESS=$(cat /IP_MINIKUBE)

adduser -S "user"
echo "user:pass" | chpasswd

/usr/sbin/pure-ftpd -j -Y 2 -p 21000:21000 -P "$MINIKUBE_IP_ADDRESS"