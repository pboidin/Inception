FROM debian:buster
RUN apt update -y && apt upgrade -y && apt install mariadb-server -y
RUN apt install vim -y && apt install curl -y
COPY tools/start.sh .
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x start.sh
CMD ["sh", "start.sh"]
