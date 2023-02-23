if [ ! -f "/etc/vsftpd.conf.bak" ]; then
	mkdir -p /var/run/vsftpd/empty

	cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
	mv /var/www/vsftpd.conf /etc/vsftpd.conf

	# Ajouter FTP_USER, changer son mot de passe et le déclarer propriétaire du dossier wordpress et de tous les sous-dossiers.
	adduser $FTP_USR --disabled-password
	echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
	chown -R $FTP_USR:$FTP_USR /var/www/html/wordpress

	# dev/null semble vide lorsqu'on le lit, alors que les données écrites sur ce périphérique "disparaissent".
	echo $FTP_USR | tee -a /etc/vsftpd.userlist &> /dev/null
fi

echo "FTP started on: 21"
usr/sbin/vsftpd /etc/vsftpd.conf