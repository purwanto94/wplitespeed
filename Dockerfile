FROM phpearth/php:7.3-litespeed

MAINTAINER "indowebsite" <purwanto94@gmail.com>

ENV container docker

# UPDATE
RUN apk update
RUN apk upgrade

# INSTALL BASH
RUN apk add --no-cache bash

# INSTALL PHP 
RUN apk add php7.3-pdo_mysql php7.3-memcached nano wget

# SETTING
RUN mv -f /var/lib/litespeed/conf/vhosts/Example/ /var/lib/litespeed/conf/vhosts/defdomain/
RUN rm -f /var/lib/litespeed/conf/vhosts/defdomain/vhconf.conf
RUN rm -f /var/lib/litespeed/conf/httpd_config.conf
RUN rm -f /usr/local/lsws/admin/conf/admin_config.conf

ADD conf/vhconf.conf /var/lib/litespeed/conf/vhosts/defdomain/vhconf.conf
ADD conf/httpd_config.conf /var/lib/litespeed/conf/httpd_config.conf
ADD conf/admin_config.conf /usr/local/lsws/admin/conf/admin_config.conf

RUN chown lsadm:lsadm /var/lib/litespeed/conf/vhosts/defdomain/vhconf.conf
RUN chown lsadm:lsadm /var/lib/litespeed/conf/httpd_config.conf
RUN chown lsadm:lsadm /usr/local/lsws/admin/conf/admin_config.conf

# MKDIR
RUN mkdir /home/defdomain
RUN mkdir /home/defdomain/html
RUN mkdir /home/defdomain/logs

# INSTALL WORDPRESS
COPY run.sh /usr/bin/
RUN chmod +x /usr/bin/run.sh
RUN run.sh
  
COPY docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]
