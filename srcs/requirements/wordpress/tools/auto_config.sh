#!/bin/bash

#	Remplacer toutes les occurrences d'une ligne dans le fichier, en écrasant le fichier:
sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";

mkdir -p /run/php/;
touch /run/php/php7.3-fpm.pid;


if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	echo "Wordpress: setting up..."

#	Après avoir vérifié les exigences, téléchargez le fichier wp-cli.phar en utilisant wget ou curl :
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;

#	"+x" signifie - définir la permission d'exécuter le fichier (x) pour tous les utilisateurs.
	chmod +x wp-cli.phar;

#	Pour utiliser WP-CLI à partir de la ligne de commande en tapant wp, rendre le fichier exécutable et
#	déplacez-le quelque part dans le PATH. Par exemple :
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html/wordpress;

#	Static Website
		mkdir -p /var/www/html/wordpress/mysite;
		mv /var/www/index.html /var/www/html/wordpress/mysite/index.html;
		mv /var/www/stylesperso.css /var/www/html/wordpress/mysite/stylesperso.css;

	wp core download --allow-root;
	wp config create --dbname=${WORDPRESS_NAME} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --allow-root

#	mv /var/www/wp-config.php /var/www/html/wordpress;
	echo "Wordpress: creating users..."	

#	Crée les tables WordPress dans la base de données, 
#	en utilisant l'URL, l'en-tête, et les données d'administration par défaut fournies
#	--url=<adresse
#		Adresse du nouveau site.
#	--title=<site title
#		Le nom du nouveau site.
#	--admin_user=<nom de l'utilisateur
#		Nom d'utilisateur de l'administrateur.
#	--admin_password=<mot de passe>]
#		Mot de passe pour l'utilisateur admin. La valeur par défaut est une chaîne générée de manière aléatoire.
#	--admin_email=<email
#		Adresse électronique de l'administrateur.

	wp core install	--allow-root \
					--url=${DOMAIN_NAME} \
					--title=${WORDPRESS_NAME} \
					--admin_user=${WORDPRESS_ROOT_LOGIN} \
					--admin_password=${MYSQL_ROOT_PASSWORD} \
					--admin_email=${WORDPRESS_ROOT_EMAIL};

#	Crée un nouvel utilisateur
#		<user-login
#	Login de l'utilisateur à créer.
#		<user-email>
#	Adresse e-mail de l'utilisateur à créer.
#		[--role=<role>]
#	Rôle de l'utilisateur à créer. Default : Rôle par défaut
#	Les valeurs possibles incluent admin, editor, author, member, subscriber.
#	[--user_pass=<password]
#	Mot de passe de l'utilisateur. Par défaut : généré aléatoirement

	wp user create	--allow-root \
					${MYSQL_USER} \
					${WORDPRESS_USER_EMAIL} \
					--user_pass=${MYSQL_PASSWORD} \
					--role=author;
	
	wp theme install inspiro --activate --allow-root

	# Bonus: Redis Cache
		sed -i "40i define( 'WP_REDIS_HOST', '$REDIS_HOST' );"      wp-config.php
    	sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               wp-config.php
    	sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               wp-config.php
   		sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          wp-config.php
    	sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            wp-config.php

    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root

	echo "Wordpress: set up!"
else
	echo "Wordpress: is already set up!"
fi

#	-R change récursivement les permissions pour les répertoires et leur contenu
chmod -R 775 /var/www/html/wordpress;

#	L'exemple suivant va changer le propriétaire de tous les fichiers et 
#	sous-répertoires du répertoire /var/www/html/wordpress pour le nouveau
#	propriétaire et groupe nommé www-data :
chown -R www-data /var/www/html/wordpress;


wp redis enable --allow-root

echo "Wordpress started on port: 9000"
/usr/sbin/php-fpm7.3 -F
