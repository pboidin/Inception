SETFILE=/var/lib/mysql/init_db
set -xve

if [ ! -f "$SETFILE" ]; then
	service mysql start
	echo "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_NAME};" | mysql
	echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" | mysql
	echo "GRANT ALL PRIVILEGES ON ${WORDPRESS_NAME}.* TO '${MYSQL_USER}'@'%';" | mysql
	echo "FLUSH PRIVILEGES;" | mysql
	echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');" | mysql
	touch $SETFILE
	service mysql stop
fi
mysqld_safe
 
#CREATE DATABASE wordpress;
#CREATE USER 'piboidin'@'%' IDENTIFIED BY '123123';
#Pour les privilèges GRANT ALL pour piboidin, donnant à cet utilisateur un contrôle total sur la base de données wordpress
#Ces privilèges sont destinés à wordpress pour s'appliquer à toutes les tables de cette base de données, 
#qui est dénoté par .* comme suit
#GRANT ALL PRIVILEGES ON wordpress.* TO 'piboidin'@'%';
#Sauvegarder vos changements
#FLUSH PRIVILEGES;

#Pour modifier les caractéristiques d'authentification ou de ressources de base de données d'un utilisateur de base de données.
#Pour permettre à un serveur proxy de se connecter en tant que client sans authentification.
#ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123123';