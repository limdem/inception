FROM alpine:3.16

ARG DATABASE_NAME
ARG DATABASE_USER_NAME
ARG DATABASE_USER_PWD
ARG WP_AUTH_KEY
ARG WP_SECURE_AUTH_KEY
ARG WP_LOGGED_IN_KEY
ARG WP_NONCE_KEY
ARG WP_AUTH_SALT
ARG WP_SECURE_AUTH_SALT
ARG WP_LOGGED_IN_SALT
ARG WP_NONCE_SALT

RUN apk update update && \
	apk upgrade && \ 
	apk add curl && \
	apk add php8 && \
	apk add php8-fpm && \
	apk add php8-opcache && \
	apk add php8-mysqli && \
	apk add php8-phar && \
	apk add mariadb-client && \
	apk add shadow

COPY tools/setupwp.sh /tmp

WORKDIR /var/www/localhost/htdocs

COPY conf/www.conf /etc/php8/php-fpm.d

RUN chmod +x /tmp/setupwp.sh && \
	/tmp/setupwp.sh 

RUN useradd www-data -g www-data && \
	chown -R www-data:www-data /var/log/php8

RUN mkdir -p /run/php

EXPOSE 9000

USER www-data

CMD ["/usr/sbin/php-fpm8", "-F"]
 
