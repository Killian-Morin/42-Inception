FROM debian:bullseye

# Update and Upgrade of the packet manager
RUN apt update -y && \
	apt upgrade -y

# Download of utilitaries
#RUN apt install vim -y && \
#	apt install curl -y

# Download of mariadb
RUN apt-get install mariadb-server procps -y
	# alternative: apt install mariadb-server mariadb-client -y

# Creation of the directories needed for MariaDB
	# /run/mysqld/ is the working directory | /var/lib/mysql is the data directory
# Recursive modificatin of the owner and group of the files and sub-folders of both directories
RUN mkdir -p /run/mysqld/ /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql

# Copy of the config file, the script launched at the start of the container and change his permission for it to be executed by anyone
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script_mariadb.sh /usr/local/script_mariadb.sh
RUN chmod +x /usr/local/script_mariadb.sh

# Port used to communicate with WordPress (default port for MySQL)
EXPOSE 3306

ENTRYPOINT [ "sh", "/usr/local/script_mariadb.sh" ]