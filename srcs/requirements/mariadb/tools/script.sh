!/bin/bash

# start mysql
service mysql start;

# create the db if does not already exists with the name in the .env
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"

# create a user that will handle the sb, the name of the user and his password is in the .env
mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"

# give priviligies to this user
mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"

# change the priviligies of the root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

# flush so that MARIADB takes the changes into account
mysql -e "FLUSH PRIVILEGES;"

# shutdown the db with the user root, thus also passing the his password
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# restart the db with the now effective changes
exec mysqld_safe