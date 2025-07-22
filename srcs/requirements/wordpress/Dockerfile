FROM debian:bullseye

# Install PHP and required extensions
RUN apt-get update > /dev/null 2>&1 && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-soap \
    php7.4-intl \
    php7.4-zip \
    php7.4-bcmath \
    wget \
    curl \
    unzip \
    > /dev/null 2>&1 && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.4/fpm/php.ini && \
    sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf && \
    mkdir -p /run/php

# Create WordPress directory
RUN mkdir -p /var/www/html/wordpress

# Download and install WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    cp -r wordpress/* /var/www/html/wordpress/ && \
    rm -rf wordpress latest.tar.gz

# Set permissions
RUN chown -R www-data:www-data /var/www/html/wordpress && \
    chmod -R 755 /var/www/html/wordpress

# Copy WordPress setup script
COPY tools/setup-wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup-wordpress.sh

# Install MySQL client for database connection check
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*

# Expose port 9000
EXPOSE 9000

# Start WordPress setup script
CMD ["/usr/local/bin/setup-wordpress.sh"]
