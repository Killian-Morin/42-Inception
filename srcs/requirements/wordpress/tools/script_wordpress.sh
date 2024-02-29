echo "<============> WordPress SCRIPT <============>"

# To give time for the MariaDB to be set in order to have less error message from the following loop
sleep 30

# Loop waiting for the MariaDB database to be accessible
while ! mariadb -u $MARIADB_USER --password=$MARIADB_PASS -h mariadb -P 3306 --silent; do
	sleep 5
	echo "Mariadb n'est pas encore pret"
done

# Check if the wp-config.php file exist (and is a regular file) in the WordPress directory (/var/www/wordpress)
# If it already exist, then WordPress as already been installed and configured
if [ -e /var/www/wordpress/wp-config.php ]; then
	echo "wp-config.php existe."
else

	# Download the latest WordPress Command-Line Interface (WP-CLI), used for managing WordPress installation via the command line
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	# Give permissions to the downloaded WP-CLI tool
	chmod +x wp-cli.phar
	# Move the WP-CLI tool to a directory so that it can be executed from anywhere
	mv wp-cli.phar /usr/local/bin/wp

	# Download the latest WordPress core files
	cd /var/www/wordpress
	wp core download --allow-root

	# Generate a 'wp-config.php' file with the configuration parameters that are passed, those values are stored in the .env
	wp config create --dbname=$MARIADB_DATABASE_NAME --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASS --dbhost=$WP_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
	# Install WordPress with the site configuration that are passed, those values are stored in the .env
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	# Create a new WordPress user, his name and password are in the .env
	wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --allow-root

fi

# Start the PHP-FPM server on the foreground
php-fpm7.4 -F
