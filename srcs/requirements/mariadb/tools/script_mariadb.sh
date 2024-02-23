echo "<============> MariaDB SCRIPT <============>"

# initialize the user and data directory for mariadb/mysql
	# the user is the user that will do the request on the DB
	# the data directory will store the DB
mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

mysqld --user=mysql --datadir=/var/lib/mysql &

pid=$!

# to wait for the launch of MariaDB
sleep 20

# change the priviligies of the root
mysql -u root -p${MARIADB_ROOT_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASS}';"

# create the db if does not already exists with the name in the .env
mysql -u root -p${MARIADB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE_NAME};"

# create a user that will handle the sb, the name of the user and his password is in the .env
mysql -u root -p${MARIADB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}' IDENTIFIED BY '${MARIADB_PASS}';"

# give priviligies to this user
mysql -u root -p${MARIADB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}';"

# flush so that MARIADB takes the changes into account
mysql -u root -p${MARIADB_ROOT_PASS} -e "FLUSH PRIVILEGES;"

#echo "------------------\n"
#mysql -u root -p${MARIADB_ROOT_PASS} -e "SHOW DATABASES;"
#echo "------------------\n"
#mysql -u root -p${MARIADB_ROOT_PASS} -e "SELECT User FROM mysql.user"
#echo "------------------\n"

# kill mysqld
kill "$pid"

# restart the db with the now effective changes
exec mysqld --user=mysql --datadir=/var/lib/mysql
