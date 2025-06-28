FROM debian:bookworm

# MariaDB Installation
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB Settings file
COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy Initialized Script
COPY tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

# Show 3306 Port
EXPOSE 3306

# Execute Initialized Script and MariaDB
CMD ["/usr/local/bin/init_db.sh"]
