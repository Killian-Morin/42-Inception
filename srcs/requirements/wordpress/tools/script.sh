!/bin/bash

#sleep 10

#if script.sh existe pas
#wp config create

#wp config create --allow-root \
				 --dbname=$SQL_DATABASE \
				 --dbuser=$SQL_USER \
				 --dbpass=$SQL_PASSWORD \
				 --dbhost=mariadb:3306 \
				 --path='/var/www/wordpress'

#wp core install > create the first user and set ≠ things for the site
#wp user create > create the second user