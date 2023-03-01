FROM alpine:3.16

ARG DATABASE_NAME
ARG DATABASE_USER_NAME
ARG DATABASE_USER_PWD
ARG DATABASE_MYSQL_PWD
ARG DATABASE_ROOT_PWD

RUN apk update && \
	apk upgrade && \
	apk add mariadb && \
	apk add mariadb-common && \
	apk add mariadb-client 

COPY tools/setupmdb.sh /tmp/setupmdb.sh

COPY conf/conf.sql /tmp

RUN mkdir -p /run/mysqld && \
	chmod +x /tmp/setupmdb.sh && \
	/tmp/setupmdb.sh && \
	chown -R mysql:root /etc/mysql \
	/var/lib/mysql /usr/lib/mariadb \
	/run/mysqld /usr/bin

EXPOSE 3306

USER mysql

CMD ["/usr/bin/mariadbd-safe"]
