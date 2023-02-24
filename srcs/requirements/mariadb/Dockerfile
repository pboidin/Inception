FROM debian:buster

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y
RUN apt install vim -y && apt install curl -y

COPY ./tools .
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

RUN service mysql start
RUN mysql> createdb.sql 
RUN rm -f createdb.sql

CMD /usr/bin/mysql_safe
