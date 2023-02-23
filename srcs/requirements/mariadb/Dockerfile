FROM debian:buster

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y
RUN apt install vim -y && apt install curl -y

COPY ./tools /var/www/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

EXPOSE 3306

RUN service mysql start && mysql < /var/www/createdb.sql && rm -f /var/www/createdb.sql

CMD /usr/bin/mysql_safe
