FROM debian:bullseye

RUN apt install wget -y && \
	apt install php8.0 -y && \
	apt install php8.0-fpm -y && \
	apt install php8.0-mysql -y && \
	apt install mariadb-client -y && \
	wget https://fr.wordpress.org/wordpress-6.4.3-fr_FR.tar.gz -P /var/www && \
	cd /var/www && tar -xvf wordpress-6.4.3-fr_FR.tar.gz && rm wordpress-6.4.3-fr_FR.tar.gz && \
	chown -R root:root /var/www/wordpress

COPY ./tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["tools/script.sh"]

CMD ["php-fpm8.0" "-F"]