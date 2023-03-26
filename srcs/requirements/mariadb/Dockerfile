FROM debian:buster

RUN apt update 
RUN apt install -y mariadb-server

COPY ./tools /var/www
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

CMD /usr/bin/mysqld_safe
