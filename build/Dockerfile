FROM ubuntu

# need that one for the installation
COPY input/localtime /etc 
# installing packages 
RUN --mount=type=cache,target=/var/cache/apt \
  --mount=type=cache,target=/var/lib/apt \
  date \
   && export DEBIAN_FRONTEND="noninteractive" \
   && apt update \
   && apt upgrade -y && yes | unminimize \
   && apt install -y  nginx php-fpm php-mysql php-xdebug \
   && apt install -y less strace mlocate net-tools \
   && date 

COPY input/apt /etc/apt
COPY input/nginx /etc/nginx
COPY input/php /etc/php

COPY input /input
RUN chmod +x /input/install.sh && /input/install.sh

VOLUME [ "/output", "/live" ]
#   ENTRYPOINT [ "/bin/bash" ]