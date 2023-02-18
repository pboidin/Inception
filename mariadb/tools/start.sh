SETFILE=/var/lib/mysql/init_db
set -vxe

if [ ! -f "$SETFILE" ]; then
    service mysql start
    echo "CREATE DATABASE IF NOT EXISTS \`${NAME_DB}\`;" | mysql
    echo "CREATE USER IF NOT EXISTS \`${USER_DB}\`@'%' IDENTIFIED BY '${PASSWORD_DB}';" | mysql
    echo "GRANT ALL PRIVILEGES ON \`${NAME_DB}\`.* TO \`${USER_DB}\`@'%' IDENTIFIED BY '${PASSWORD_DB}';" | mysql
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD_DB}';" | mysql
    echo "FLUSH PRIVILEGES;" | mysql
    touch $SETFILE
    service mysql stop 
fi
mysqld_safe