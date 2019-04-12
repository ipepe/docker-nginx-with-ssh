#!/usr/bin/env bash

nginx -t

service nginx start
service ssh start

mkdir -p /home/webapp/.ssh /home/webapp/html
touch /home/webapp/.ssh/authorized_keys
chown webapp:webapp -R /home/webapp/
chmod 600 /home/webapp/.ssh/*

tail -f /var/log/nginx/access.log