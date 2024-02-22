echo "<============> WordPress SCRIPT <============>"

php-fpm7.3 -v

# Boucle verification mariadb qui attend que mariadb soit up
while ! mariadb -u $MARIADB_USER --password=$MARIADB_PASS -h mariadb -P 3306 --silent; do
	sleep 1
	echo "Mariadb n'est pas encore pret"
done

# Affichage dans le terminal des bases de donnees
echo "------------------\n"
mariadb -u $MARIADB_USER --password=$MARIADB_PASS -h mariadb -P 3306 -e "SHOW DATABASES;"
echo "------------------\n"

# Installation de Wordpress si necessaire
if [ -e /var/www/wordpress/wp-config.php ]
then echo "wp-config existe."
else

	# Installation de wp-cli
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	# Installation de wordpress
	cd /var/www/wordpress
	wp core download --allow-root

	# Configuration de wordpress : connection a la base de donnees et creation des users de wordpress (admin et user supplémentaire)
	wp config create --dbname=$MARIADB_DATABASE_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASS --dbhost=$WP_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	# creation de l'user et set ≠ choses pour le site
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	# creation du second user
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

fi

# Lancement de php-fpm
php-fpm7.3 -F
