if [ ! -f "/etc/redis/redis.conf.bak" ]; then
    cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

    #   Pour changer l'adresse IP dans tous les fichiers de zone, utilisez la commande suivant, 
    #   -i changer le fichier à la place de s signifie remplacer
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf

    #   Lorsque la mémoire de votre instance Redis est pleine et qu'une nouvelle entrée arrive, 
    #   Redis déplace les clés pour faire de la place à l'entrée, selon la politique de mémoire maximale de votre instance.
    sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf

    #   noevicrion
	#   Cette politique indique à Redis de ne pas supprimer les données lorsque la limite de mémoire est atteinte. 
	#   Au lieu de cela, Redis retournera une erreur et ne sera pas en mesure d'exécuter la commande add data.
	#   Cette politique est particulièrement utile lorsque vous devez supprimer manuellement des clés, ou 
	#   prévenir la perte accidentelle de données.

	#   Allkeys-LRU
	#   La deuxième politique est allkeys-lru. Ce type de politique supplante toute dernière clé utilisée ou LRU.
	#   Cette politique suppose que vous n'avez pas besoin des clés récemment utilisées et les supprime. 
	#   Cela évite une erreur de Redis en cas de contraintes de mémoire.
    sed -i "s|# maxmemory-policy noevicrion|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf
fi

#   Le serveur Redis retournera une erreur à tout client se connectant à des adresses de boucles externes en mode sécurisé.
redis-server --protected-mode no