FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy initialization script
COPY tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

# Create data directory and required directories
RUN mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/log/mysql && \
    chown -R mysql:mysql /var/run/mysqld

# Expose port 3306
EXPOSE 3306

# Start MariaDB
CMD ["/usr/local/bin/init_db.sh"]
