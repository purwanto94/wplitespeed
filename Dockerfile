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

# MKDIR
RUN mkdir /home/defdomain
RUN mkdir /home/defdomain/html
RUN mkdir /home/defdomain/logs

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

# INSTALL WORDPRESS
COPY run.sh /usr/bin/
RUN chmod +x /usr/bin/run.sh
RUN run.sh

# PORT
EXPOSE 80
EXPOSE 7080
  
COPY docker-entrypoint.sh /bin/bash/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/bin/bash"]
