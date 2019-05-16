FROM phpearth/php:7.3-litespeed

MAINTAINER "indowebsite" <purwanto94@gmail.com>

ENV container docker

# UPDATE
RUN apk update
RUN apk upgrade

# INSTALL BASH
RUN apk add --no-cache bash

# INSTALL PHP 
RUN apk add php7.3-pdo_mysql php7.3-memcached

# INSTALL WORDPRESS
#COPY run.sh /usr/bin/
#RUN chmod +x /usr/bin/run.sh
#RUN run.sh
  
COPY docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
