FROM debian:bullseye

# maj de l'installateur
RUN apt update -y && \
	apt upgrade -y

# Installation des utilitaires
#RUN apt install vim -y && \
#	apt install curl -y

# Installation de mariadb
RUN apt-get install mariadb-server procps -y
	# alternative: apt install mariadb-server mariadb-client -y

# Creation des directories nécessaires au bon fonctionnement de MariaDB
	# /run/mysqld/ pour le directory de travail | /var/lib/mysql pour le data directory
# Modification récursive du propriétaire des fichiers et sous-dossiers de ces folders
RUN mkdir -p /run/mysqld/ /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql

# Copie du fichier de config de mariadb et du script de lancement
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script_mariadb.sh /usr/local/script_mariadb.sh
RUN chmod +x /usr/local/script_mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/local/script_mariadb.sh" ]