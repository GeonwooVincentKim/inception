#!/bin/bash

# Start MariaDB Service
service mariadb start

# Wait until initialization process finish
sleep 5

# Write DB and User
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Stop MariaDB
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Execute MariaDB
exec mysqld_safe
