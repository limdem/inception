#!/bin/sh

if [ ! "$(ls -A /var/www/localhost/htdocs)" ]
then
	curl -O -s https://fr.wordpress.org/latest-fr_FR.tar.gz
	tar -xzf latest-fr_FR.tar.gz
	mv wordpress/* .
	rm -rf latest-fr_FR.tar.gz wordpress
	sed -i "s/votre_nom_de_bdd/$DATABASE_NAME/" wp-config-sample.php
	sed -i "s/votre_utilisateur_de_bdd/$DATABASE_USER_NAME/" wp-config-sample.php
	sed -i "s/votre_mdp_de_bdd/$DATABASE_USER_PWD/" wp-config-sample.php
	sed -i 's/localhost/mariadb/' wp-config-sample.php
	sed -i 's/utf8/utf8mb4/' wp-config-sample.php
	sed -i "s/define( 'AUTH_KEY',         'mettez une phrase unique ici' );/define( 'AUTH_KEY',         '$WP_AUTH_KEY' );/" wp-config-sample.php
	sed -i "s/define( 'SECURE_AUTH_KEY',  'mettez une phrase unique ici' );/define( 'SECURE_AUTH_KEY',  '$WP_SECURE_AUTH_KEY' );/" wp-config-sample.php
	sed -i "s/define( 'LOGGED_IN_KEY',    'mettez une phrase unique ici' );/define( 'LOGGED_IN_KEY',    '$WP_LOGGED_IN_KEY' );/" wp-config-sample.php
	sed -i "s/define( 'NONCE_KEY',        'mettez une phrase unique ici' );/define( 'NONCE_KEY',        '$WP_NONCE_KEY' );/" wp-config-sample.php
	sed -i "s/define( 'AUTH_SALT',        'mettez une phrase unique ici' );/define( 'AUTH_SALT',        '$WP_AUTH_SALT' );/" wp-config-sample.php
	sed -i "s/define( 'SECURE_AUTH_SALT', 'mettez une phrase unique ici' );/define( 'SECURE_AUTH_SALT', '$WP_SECURE_AUTH_SALT' );/" wp-config-sample.php
	sed -i "s/define( 'LOGGED_IN_SALT',   'mettez une phrase unique ici' );/define( 'LOGGED_IN_SALT',   '$WP_LOGGED_IN_SALT' );/" wp-config-sample.php
	sed -i "s/define( 'NONCE_SALT',       'mettez une phrase unique ici' );/define( 'NONCE_SALT',       '$WP_NONCE_SALT' );/" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
	rm wp-config-sample.php
fi
