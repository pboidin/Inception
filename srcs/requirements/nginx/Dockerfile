FROM debian:buster

RUN apt update -y 
RUN apt install -y nginx
RUN apt install -y openssl
RUN apt install -y curl

EXPOSE 443

COPY ./conf/default /etc/nginx/sites-enabled/default
COPY ./tools/auto_config.sh /var/www

CMD bash /var/www/auto_config.sh