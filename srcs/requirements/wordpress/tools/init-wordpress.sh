#!/bin/bash

# Wait for WordPress to be ready
until curl -f http://wordpress:9000 >/dev/null 2>&1; do
    echo "Waiting for WordPress..."
    sleep 2
done

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Go to WordPress directory
cd /var/www/html/wordpress

# Check if WordPress is already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    
    # Install WordPress
    wp core install \
        --url=https://geonwkim.42.fr \
        --title="My WordPress Site" \
        --admin_user=superuser \
        --admin_password=adminpass123 \
        --admin_email=admin@geonwkim.42.fr \
        --allow-root
    
    # Create a regular user
    wp user create wpuser2 user@geonwkim.42.fr \
        --user_pass=userpass123 \
        --role=author \
        --allow-root
    
    # Create a sample page
    wp post create \
        --post_type=page \
        --post_title="Welcome" \
        --post_content="Welcome to my WordPress site!" \
        --post_status=publish \
        --allow-root
    
    echo "WordPress installation completed!"
else
    echo "WordPress is already installed!"
fi 