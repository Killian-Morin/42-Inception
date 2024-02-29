echo "<============> MariaDB SCRIPT <============>"

# Initialize the data directory for MariaDB/MySQL, this step is necessary when setting up a MySQL server for the first time
	# --initialize indicate that we define the datadir of the server here
	# The user is the user that will run the MySQL server
	# The data directory will store the DB, it's the working directory of MariaDB
mysqld --initialize --user=mysql --datadir=/var/lib/mysql;

# Starts the MariaDB server with the configurations provided with the parameters:
	# --user -> indicate that the user mysql is the user under which the MariaDB server process run
	# --datadir -> indicate the data directory that is used by MariaDB to search databases and related files
	# it is possible to launch this process in the background by adding '&'' at the end of the line in the place of the ';'
mysqld --user=mysql --datadir=/var/lib/mysql &

# Wait for the MariaDB server to be launched correctly
sleep 30

# Get the process id of the process started in the background by the previous command
pid=$!

# Change the password of the root user to the value stored in the environment variable ${MARIADB_ROOT_PASS}
mysql -u root -p${MARIADB_ROOT_PASS} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASS}';"

# Create the DB if does not already exists with the name in the .env
mysql -u root -p${MARIADB_ROOT_PASS} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE_NAME};"

# Create a new user (that will handle the db), his name and his password are in the .env
mysql -u root -p${MARIADB_ROOT_PASS} -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}' IDENTIFIED BY '${MARIADB_PASS}';"

# Give priviligies to this user
	# The *.* indicates all databases and all tables
mysql -u root -p${MARIADB_ROOT_PASS} -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}';"

# Flush, equivalent of a reload so that the server takes the changes of priviligies into account instantly
mysql -u root -p${MARIADB_ROOT_PASS} -e "FLUSH PRIVILEGES;"

# Kill the MySQL server process that was launched in order to restart with all the changes effective
kill "$pid"

# Restart the db with the now effective changes
# Use 'exec' to replace the current shell process with the specified command 'mysqld', mysqld become the new process for the script
exec mysqld --user=mysql --datadir=/var/lib/mysql
