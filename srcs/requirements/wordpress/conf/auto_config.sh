#!/bin/bash

set -xve

sleep 10
if [ -f "/var/www/wordpress/wp-config.php" ]; then
	rm /var/www/wordpress/wp-config.php
fi
wp config create    --allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb --path='/var/www/wordpress'

wp core install --url="$DOMAIN_NAME" \
                --title="$TITLE" \
                --admin_user="$DB_ROOT_USER" \
                --admin_password="$DB_ROOT_PASSWORD" \
                --admin_email="$DB_ROOT_EMAIL" \
                --path="$WP_PATH" --allow-root

php-fpm7.3 -F -R