#!/bin/sh

echo "user:pass" | chpasswd

chmod 600 /etc/ssh/ssh_host_rsa_key

update-ca-certificates

/usr/sbin/sshd
/usr/sbin/nginx -g 'daemon off;'