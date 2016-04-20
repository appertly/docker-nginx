#!/bin/bash

sed -i "s/%fpm-ip%/$FPM_PORT_9000_TCP_ADDR/" /etc/nginx/nginx.conf

if [ ! -e "/etc/ssl/dhparam.pem" ]
then
  openssl dhparam -out "/etc/ssl/dhparam.pem" 2048 2>/dev/null
fi

if [ ! -e "/etc/ssl/cert.pem" ] || [ ! -e "/etc/ssl/private/key.pem" ]
then
  openssl req -x509 -newkey rsa:4096 \
    -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=$HOSTNAME" \
    -keyout "/etc/ssl/private/key.pem" \
    -out "/etc/ssl/cert.pem" \
    -days 3650 -nodes -sha256 2>/dev/null
fi

update-ca-certificates

exec nginx -g "daemon off;"
