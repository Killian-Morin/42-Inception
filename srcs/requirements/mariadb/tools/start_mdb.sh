echo "<============> MariaDB SCRIPT <============>"

# start mysql
# service mysql start;

# initialize the user and data directory for mariadb/mysql
	# the data directory will store the DB
	# the user is the user that will do the request on the DB
mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

mysqld --user=mysql --datadir=/var/lib/mysql &

pid=$!

# to wait for the launch of MariaDB
sleep 10

# change the priviligies of the root
mysql -u root -p${MARIADB_ROOT_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASS}';"

# create the db if does not already exists with the name in the .env
mysql -u root -p${MARIADB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE_NAME};"

# create a user that will handle the sb, the name of the user and his password is in the .env
mysql -u root -p${MARIADB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS ${MARIADB_USER}@'localhost' IDENTIFIED BY '${MARIADB_PASS}';"

# give priviligies to this user
mysql -u root -p${MARIADB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE_NAME}.* TO ${MARIADB_USER}@'%' IDENTIFIED BY '${MARIADB_PASS}';"

# flush so that MARIADB takes the changes into account
mysql -u root -p${MARIADB_ROOT_PASS} -e "FLUSH PRIVILEGES;"

# shutdown the db with the user root, thus also passing the his password
# mysqladmin -u root -p${MARIADB_ROOT_PASS} shutdown

# To kill mysqld
kill "$pid"

# restart the db with the now effective changes
#exec mysqld_safe

exec mysqld --user=mysql --datadir=/var/lib/mysql