FROM debian:buster

RUN apt update -y && apt-get install -y wget

RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www

# Bonus: Static Website
COPY conf/index.html /var/www/index.html
COPY conf/styles.css /var/www/styles.css

CMD bash /var/www/auto_config.sh