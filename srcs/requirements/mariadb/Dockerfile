FROM debian:bullseye

RUN apt update -y && \
	apt upgrade -y && \
	apt install mariadb-server -y && \
	mkdir -p /run/mysqld/ /var/lib/mysql && \
	chown -R mysql:mysql /run/mysqld; chown -R mysql:mysql /var/lib/mysql && \
	#chmod +x ./tools/script.sh && \
	apt install vim -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh .

RUN chmod +x script.sh

CMD ["/bin/bash", "script.sh"]