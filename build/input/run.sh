#!/bin/bash
set -xeE
echo 'starting nginx and php'
rm -rfv /live/tmp/*
/etc/init.d/nginx restart
/etc/init.d/php8.1-fpm restart

sleep 2

# sleep 86400
top