#!/bin/sh

sed -i 's|\[client-server\]|\[client-server\]\nport=3306\nsocket=/run/mysqld/mysqld.sock|g' /etc/my.cnf
sed -i 's|\[mysqld\]|\[mariadbd-safe\]\nuser=mysql\ndatadir=/var/lib/mysql\nsocket=/run/mysqld/mysqld.sock|g' /etc/my.cnf
sed -i 's|.*bind-address\s*=.*|bind-address=0.0.0.0|g' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's|.*skip-networking.*|#skip-networking|g' /etc/my.cnf.d/mariadb-server.cnf

if [ ! "$(ls -A /var/lib/mysql)" ]
then
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
	/usr/bin/mariadbd --user=root &>/tmp/isready.txt &

	while ! grep -q "Version: '10.6.12-MariaDB'  socket: '/run/mysqld/mysqld.sock'  port: 3306  MariaDB Server" /tmp/isready.txt
	do
		sleep 2
	done

	mysql -u root <<EOF
	CREATE DATABASE $DATABASE_NAME;
	USE $DATABASE_NAME;
	SOURCE /tmp/conf.sql;
	CREATE USER '$DATABASE_USER_NAME'@'wordpress.inception_network' IDENTIFIED BY '$DATABASE_USER_PWD';
	CREATE USER '$DATABASE_USER_NAME'@localhost IDENTIFIED BY '$DATABASE_USER_PWD';
	GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER_NAME'@'wordpress.inception_network';
	GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER_NAME'@'localhost' WITH GRANT OPTION;
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
	ALTER USER 'mysql'@'localhost' IDENTIFIED BY '$DATABASE_MYSQL_PWD';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$DATABASE_ROOT_PWD';
EOF
	rm /tmp/isready.txt

fi
