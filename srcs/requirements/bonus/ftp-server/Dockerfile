FROM debian:buster

RUN apt update
RUN apt install -y vsftpd

COPY conf/vsftpd.conf /var/www/vsftpd.conf
COPY tools/config.sh /var/www/config.sh

CMD bash /var/www/config.sh