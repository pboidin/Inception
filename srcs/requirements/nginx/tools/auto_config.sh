#!/bin/bash

#	-openssl
#	Utilitaire pour créer un certificat
#	-command req
#		Crée et traite d'abord les demandes de certificat
#	-x509
#		Cette option affiche un certificat auto-signé au lieu de demander un certificat. 
#		Normalement, cette option est utilisée pour générer un certificat de test ou un certificat racine auto-signé.
#	-nodes
#		Si cette option est spécifiée, si une clé privée est générée, elle ne sera pas cryptée.
#		days n
#	Lorsque l'option -x509 est utilisée, elle spécifie le nombre de jours pour certifier le certificat.
#	argument -newkey
#		cette option crée une nouvelle demande de certificat et une nouvelle clé privée. L'argument prend l'une des formes suivantes. 
#	rsa:nbits , où nbits est le nombre de bits, génère une clé RSA de taille nbits.
#	-keyout nom de fichier
#		Ceci donne le nom de fichier pour écrire la clé privée nouvellement générée.
#	-out nom de fichier
#		Ceci donne le nom du fichier de sortie à écrire ou la sortie par défaut
#	-subj argument
#		Remplace le champ sujet de la requête d'entrée par les données spécifiées et produit la requête modifiée.
if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	echo "Nginx: setting up ssl ...";
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=piboidin.42.fr/UID=piboidin"
	echo "Nginx: ssl is set up!";
fi

# Exécuter nginx
# Nginx utilise la directive daemon off pour fonctionner en avant-plan.
nginx -g 'daemon off;';