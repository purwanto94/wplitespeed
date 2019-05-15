FROM phpearth/php:7.3-litespeed

MAINTAINER "indowebsite" <purwanto94@gmail.com>

ENV container docker

# UPDATE
RUN apk update
RUN apk upgrade

# INSTALL PHP 
RUN apk add php7.3-pdo_mysql php7.3-memcached

# INSTALL WORDPRESS
ENV WORDPRESS_VERSION latest
ENV WORDPRESS_SHA1 36459a4621b9e1909c606a98d08625b9e0e25bbc

RUN set -ex; \
  rm -rf /var/lib/litespeed/Example/html/*; \
	curl -o wordpress.tar.gz -fSL "https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz"; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /var/lib/litespeed/Example/html; \
	rm wordpress.tar.gz; \
  mv /var/lib/litespeed/Example/html/wordpress/* /var/lib/litespeed/Example/html; \
	chown -R nobody:nobody /var/lib/litespeed/Example/html
  
COPY docker-entrypoint.sh /usr/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
