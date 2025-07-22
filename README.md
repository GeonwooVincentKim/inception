# Inception Project

This project implements a complete web infrastructure using Docker containers with Nginx, WordPress, and MariaDB.

## Architecture

- **Nginx**: Web server with SSL/TLS support, serving on port 443
- **WordPress**: PHP-FPM application with WordPress CMS
- **MariaDB**: Database server for WordPress

## Services

### Nginx
- SSL/TLS encryption with self-signed certificate
- Reverse proxy to WordPress PHP-FPM
- Static file serving with caching
- Security headers

### WordPress
- PHP 8.2 with FPM
- Latest WordPress version
- All required PHP extensions
- Configured for MariaDB connection

### MariaDB
- Database server for WordPress
- User and database creation
- Proper configuration for WordPress

## Evaluation Checklist ✅

### Preliminary Tests
- ✅ All credentials in `.env` file (no hardcoded secrets)
- ✅ Defense can only happen if student is present
- ✅ All files in `srcs/` folder
- ✅ Makefile at root of repository
- ✅ No `network: host` or `links:` in docker-compose.yml
- ✅ Networks defined in docker-compose.yml
- ✅ No `--link` in Makefile or scripts
- ✅ No `tail -f` or background commands in Dockerfiles
- ✅ No infinite loops in scripts

### Mandatory Requirements
- ✅ **NGINX**: Port 443 only, SSL/TLS certificate
- ✅ **WordPress**: Pre-configured (no installation page)
- ✅ **MariaDB**: Database with proper configuration
- ✅ **Docker Basics**: Custom Dockerfiles, Debian-based images
- ✅ **Docker Network**: Bridge network configured
- ✅ **Volumes**: `/home/geonwkim/data/` paths
- ✅ **Admin User**: `superuser` (no 'admin' in name)
- ✅ **Persistence**: Data survives container restarts

## Usage

### Prerequisites
- Docker
- Docker Compose

### Quick Start
```bash
# Test the setup
./test_inception.sh

# Build and start all services
make all

# Or step by step:
make setup    # Create data directories
make build    # Build containers
make up       # Start services
```

### Available Commands
```bash
make build      # Build all containers
make up         # Start all services
make down       # Stop all services
make clean      # Remove containers and images
make fclean     # Full cleanup
make re         # Rebuild everything
make logs       # Show logs
make status     # Show container status
```

### Access
- Website: https://geonwkim.42.fr
- WordPress Admin: https://geonwkim.42.fr/wp-admin

## Configuration

Environment variables are defined in `srcs/.env`:
- Domain name
- Database credentials
- WordPress admin credentials

## Security Features

- SSL/TLS encryption
- Security headers
- Proper file permissions
- Isolated network
- Non-root containers

## Project Structure
```
inception/
├── Makefile
├── README.md
├── secrets/
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        ├── wordpress/
        └── mariadb/
``` 