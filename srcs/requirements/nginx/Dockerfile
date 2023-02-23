FROM debian:buster

RUN apt update -y && apt upgrade -y && apt install nginx -y && apt install openssl -y
RUN apt install vim -y && apt install curl -y

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/start.sh /var/www

CMD bash /var/www/auto_config.sh