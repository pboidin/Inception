FROM debian:buster

RUN apt update -y && apt-get install -y wget

RUN apt-get install -y php7.3\
						php-fpm\
						php-mysql\
						mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz

RUN	chown -R root:root /var/www/wordpress
COPY conf/auto_config.sh .
RUN chmod +x auto_config.sh
RUN mkdir -p /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/local/bin/wp
RUN wp core download --allow-root

CMD [ "sh", "auto_config.sh" ]