FROM debian:buster

RUN apt update -y && apt-get install -y wget
RUN apt install -y curl
RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						php-json\
						php-cli\
						php-mbstring\
						php-xml\
						php-gd\
						php-curl\
						mariadb-client


COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools /var/www

# Bonus: Static Website
COPY conf/index.html /var/www/index.html
COPY conf/stylesperso.css /var/www/stylesperso.css

CMD bash /var/www/auto_config.sh
