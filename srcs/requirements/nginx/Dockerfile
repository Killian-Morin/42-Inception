FROM debian:bullseye

# Update and Upgrade of the packet manager
RUN apt-get update -y && \
	apt upgrade -y

# Download of utilitaries
# RUN apt install -y vim && \
#	apt install -y curl

# Download of nginx
RUN apt-get install -y nginx

# Creation of a directory that will hold future SSL information and Download of ssl
RUN mkdir -p /etc/nginx/ssl && \
	apt install -y openssl

# Creation of the self signed certificate using openssl
	# req -> request for a certificate signature or to create a self signed certificate
	# -x509 -> indicate that we want a self signed certificate
	# -nodes -> if a private key is created, it will not be encrypted
	# -out -> file to write the ouput, i.e. the certificate
	# -keyout -> file to write the key that is created
	# -subj -> set information concerning the certificate (origin, for who ...)
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=${DOMAIN_NAME}/emailAddress=${WP_ADMIN_EMAIL}"

# Creation of the directories needed for NGINX and modification of the permissions of a folder so that the user managing NGINX can manipulate them
RUN mkdir -p /var/run/nginx && \
	mkdir -p /var/www/wordpress && \
	chmod -R 755 /var/www/wordpress

# Recursive modification of the owner and group of the files and sub-folders of /var/www/wordpress
# The user 'www-data' is the user that will manage NGINX, it's the one by default but he is explicitly chosen in the config file
RUN chown -R www-data:www-data /var/www/wordpress

# Copy of the config file, the script launched at the start of the container and change his permission for it to be executed by anyone
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/script_nginx.sh /usr/local/script_nginx.sh
RUN chmod +x /usr/local/script_nginx.sh

# Required port for SSL (http)
EXPOSE 443

ENTRYPOINT [ "sh", "/usr/local/script_nginx.sh" ]