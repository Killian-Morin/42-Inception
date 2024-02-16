FROM debian:bullseye

RUN	apt install nginx -y && \
	mkdir -p /etc/nginx/ssl && \
	apt install openssl -y && \
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=kmorin.42.fr/UID=kmorin" && \
	mkdir -p /var/run/nginx && \
	chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]