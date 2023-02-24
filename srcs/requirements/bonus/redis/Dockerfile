FROM debian:buster

RUN apt update
RUN apt install -y redis

COPY tools/config.sh /var/www/config.sh

CMD bash /var/www/config.sh