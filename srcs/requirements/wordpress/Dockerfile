FROM debian:bullseye

# Update and Upgrade of the packet manager
RUN apt update -y && \
	apt upgrade -y

# Download of utilitaries
# RUN apt install -y vim && \
	# apt install -y curl

# Download of wget
RUN apt-get install -y wget

# Download of php and php-fpm for the management of .php requests
# Download of php7.4-mysql and mariadb-client for the management of .sql requests
RUN apt-get -y install php7.4 php7.4-fpm php7.4-mysql mariadb-client

# Creation of the directory for WordPress and of the working directory for php
RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php

# Recursive modification of the owner and group of the files and sub-folders of /var/www and change of its permissions
RUN chown -R www-data:www-data /var/www
RUN chmod -R 755 /var/www

# Copy of the config file, the script launched at the start of the container and change his permission for it to be executed by anyone
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/script_wordpress.sh /usr/local/script_wordpress.sh
RUN chmod +x /usr/local/script_wordpress.sh

# Port used to communicate with NGINX
EXPOSE 9000

ENTRYPOINT [ "sh", "/usr/local/script_wordpress.sh" ]