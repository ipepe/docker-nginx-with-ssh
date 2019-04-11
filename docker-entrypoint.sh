#!/usr/bin/env bash

nginx -t

service nginx start
service ssh start

tail -f /var/log/nginx/access.log