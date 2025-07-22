#!/bin/bash

# Create required directories
mkdir -p /run/php

# Wait for MariaDB to be ready
until mysql -h mariadb -u $WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD -e "SELECT 1" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Check if WordPress is already configured
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Setting up WordPress..."
    
    # Create wp-config.php
    cat > /var/www/html/wordpress/wp-config.php << EOF
<?php
define('DB_NAME', '$WORDPRESS_DB_NAME');
define('DB_USER', '$WORDPRESS_DB_USER');
define('DB_PASSWORD', '$WORDPRESS_DB_PASSWORD');
define('DB_HOST', '$WORDPRESS_DB_HOST');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         'put your unique phrase here');
define('SECURE_AUTH_KEY',  'put your unique phrase here');
define('LOGGED_IN_KEY',    'put your unique phrase here');
define('NONCE_KEY',        'put your unique phrase here');
define('AUTH_SALT',        'put your unique phrase here');
define('SECURE_AUTH_SALT', 'put your unique phrase here');
define('LOGGED_IN_SALT',   'put your unique phrase here');
define('NONCE_SALT',       'put your unique phrase here');

\$table_prefix = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', __DIR__ . '/');

require_once ABSPATH . 'wp-settings.php';
EOF

    # Set proper permissions
    chown -R www-data:www-data /var/www/html/wordpress
    chmod -R 755 /var/www/html/wordpress
    chmod 644 /var/www/html/wordpress/wp-config.php
    
    # Install WP-CLI
    echo "Installing WP-CLI..."
    wget -q https://github.com/wp-cli/wp-cli/releases/download/v2.10.0/wp-cli-2.10.0.phar -O wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    
    # Wait a moment for database to be fully ready
    sleep 5
    
    # Install WordPress
    wp core install --url=https://geonwkim.42.fr --title="Inception WordPress" \
        --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL \
        --path=/var/www/html/wordpress --allow-root
    
    # Create additional user
    wp user create $WP_USER $WP_USER_EMAIL --role=subscriber --user_pass=$WP_USER_PASSWORD \
        --path=/var/www/html/wordpress --allow-root
    
    echo "WordPress installation completed!"
fi

# Start PHP-FPM
exec php-fpm7.4 -F 