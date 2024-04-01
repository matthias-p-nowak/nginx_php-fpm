#!/bin/sh
set -xeE

useradd nginx 
useradd live-site
usermod -a -G live-site nginx
updatedb

mkdir -pv /var/log/php /var/log/live-site
chown live-site /var/log/live-site
rm /etc/php/8.1/fpm/pool.d/www.conf


chmod +x /input/run.sh
echo 'all done'

