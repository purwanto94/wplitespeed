FROM phpearth/php:7.2-litespeed

MAINTAINER "indowebsite" <purwanto94@gmail.com>

ENV container docker

# UPDATE
RUN apk update
RUN apk upgrade

# INSTALL BASH
RUN apk add --no-cache bash

# INSTALL PHP 
RUN apk add php7.2-pdo_mysql php7.2-memcached nano wget

# SETTING
RUN rm -f /var/lib/litespeed/conf/vhosts/Example/vhconf.conf
RUN rm -f /var/lib/litespeed/conf/httpd_config.conf

ADD conf/vhconf.conf /var/lib/litespeed/conf/vhosts/Example/vhconf.conf
ADD conf/httpd_config.conf /var/lib/litespeed/conf/httpd_config.conf

RUN chown lsadm:lsadm /var/lib/litespeed/conf/vhosts/Example/vhconf.conf
RUN chown lsadm:lsadm /var/lib/litespeed/conf/httpd_config.conf

# INSTALL WORDPRESS
COPY run.sh /usr/bin/
RUN chmod +x /usr/bin/run.sh
RUN run.sh

# PORT
EXPOSE 80
EXPOSE 7080
  
#COPY docker-entrypoint.sh /bin/

#ENTRYPOINT ["docker-entrypoint.sh"]

#CMD ["/bin/bash"]
