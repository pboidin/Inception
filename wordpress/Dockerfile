FROM debian:buster

RUN apt update -y && apt upgrade -y && apt-get install -y wget php7.3\ php-fpm\ php-mysql\ mariadb-client

WORKDIR /var/www

RUN wget -c https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz 
RUN tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz

RUN	chown -R root:root /var/www/wordpress
