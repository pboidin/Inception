FROM debian:buster

RUN apt update -y && apt upgrade -y && apt install nginx -y && apt install openssl -y
RUN apt install vim -y && apt install curl -y

# Creation of a directory to stock the certificate and the key for a secure connexion
RUN mkdir -p /etc/nginx/ssl

# Generation of the SSL Certificate, req= type, nodes private key without password & stockage of certificate and key.
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=piboidin.42.fr/UID=piboidin"

# Creation of mkdir to sotck configuration files of NGINX
RUN mkdir -p /var/run/nginx

# Change the the configuration file of NGINX when the containers start.
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Be sure that we have the right
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html;

CMD [ "nginx", "-g", "daemon off;" ]