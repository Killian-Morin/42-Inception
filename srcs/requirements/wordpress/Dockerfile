FROM debian:bullseye

# maj de l'installateur
RUN apt update -y && \
	apt upgrade -y

# Installation des utilitaires
# RUN apt install -y vim && \
	# apt install -y curl

# Installation de wget
RUN apt-get install -y wget

# Installation de php et de php-fpm pour la gestion des requêtes .php
# Installation de mysql et de mariadb-client pour la gestion des requêtes .sql
RUN apt-get -y install php7.4 php7.4-fpm php7.4-mysql mariadb-client

# wget https://fr.wordpress.org/wordpress-6.4.3-fr_FR.tar.gz -P /var/www
# cd /var/www && tar -xvf wordpress-6.4.3-fr_FR.tar.gz && rm wordpress-6.4.3-fr_FR.tar.gz

# Création du directory pour wordpress et du directory de travail pour php
RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php

# Modification récursive du propriétaire des fichiers et sous-dossiers de /var/www et des permissions
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

# Copie du fichier de config de php et du script de lancement
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
# renommer le script vers start_wp.sh ?
COPY tools/start_wp.sh /usr/local/start_wp.sh
RUN chmod +x /usr/local/start_wp.sh

EXPOSE 9000

ENTRYPOINT [ "sh", "/usr/local/start_wp.sh" ]