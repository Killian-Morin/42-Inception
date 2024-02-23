FROM debian:bullseye

# maj de l'installateur
RUN apt-get update -y && \
	apt upgrade -y

# Installation des utilitaires
# RUN apt install -y vim && \
#	apt install -y curl

# Installation de nginx
RUN apt-get install -y nginx

# Installation de ssl
RUN mkdir -p /etc/nginx/ssl && \
	apt install -y openssl

# Configuration du certificat auto signé
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=${DOMAIN_NAME}/emailAddress=${WP_ADMIN_EMAIL}"

# Création des directories nécessaires au bon fonctionnement de NGINX et modification des droits pour que nginx puisse les manipuler
RUN mkdir -p /var/run/nginx && \
	mkdir -p /var/www/wordpress && \
	chmod -R 755 /var/www/wordpress

# Modification récursive du propriétaire des fichiers et sous-dossiers de /var/www/wordpress
# L'user 'www-data' est l'user par défaut pour la gestion de NGINX et correspond à celui choisi dans conf/nginx.conf
RUN chown -R www-data:www-data /var/www/wordpress

# Copie du fichier de config et du script de lancement
COPY conf/nginx.conf /etc/nginx/nginx.conf
# renommer le script vers start_ngx.sh ?
COPY tools/start_ngx.sh /usr/local/start_ngx.sh
RUN chmod +x /usr/local/start_ngx.sh

# Port requis pour SSL (https)
EXPOSE 443

ENTRYPOINT [ "sh", "/usr/local/start_ngx.sh" ]