#!/bin/bash

IP_ADDRESS=$(cat /tmp/IP_MINIKUBE)
sed -i 's/IP_ADDRESS/'"$IP_ADDRESS"'/g' /etc/telegraf/telegraf.conf

exec /usr/bin/telegraf $@