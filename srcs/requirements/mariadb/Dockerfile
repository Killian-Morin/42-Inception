FROM debian:bullseye

# maj de l'installateur
RUN apt update -y && \
	apt upgrade -y

# Installation des utilitaires et de mariadb
RUN apt install vim -y && \
	apt install curl -y && \
	apt-get install mariadb-server procps -y
	# apt install mariadb-server mariadb-client -y

# Creation des directories nécessaires au bon fonctionnement de MariaDB
	# /run/mysqld/ pour le directory de travail | /var/lib/mysql pour le data directory
# Modification récursive du propriétaire des fichiers et sous-dossiers de ces folders
RUN mkdir -p /run/mysqld/ /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql

# Copie du fichier de config de mariadb et du script de lancement
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/start_mdb.sh /usr/local/start_mdb.sh
RUN chmod +x /usr/local/start_mdb.sh

EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/local/start_mdb.sh" ]