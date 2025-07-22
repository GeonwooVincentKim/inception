#!/bin/bash

echo "=== Inception Project Test Script ==="
echo

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    exit 1
fi

# Check if data directories exist
if [ ! -d "./data" ]; then
    echo "❌ Data directory ./data does not exist"
    echo "Run: make setup"
    exit 1
fi

echo "✅ Data directory exists"

# Check if docker-compose.yml exists
if [ ! -f "srcs/docker-compose.yml" ]; then
    echo "❌ docker-compose.yml not found in srcs/"
    exit 1
fi

echo "✅ docker-compose.yml found"

# Check if .env file exists
if [ ! -f "srcs/.env" ]; then
    echo "❌ .env file not found in srcs/"
    exit 1
fi

echo "✅ .env file found"

# Check if Makefile exists
if [ ! -f "Makefile" ]; then
    echo "❌ Makefile not found"
    exit 1
fi

echo "✅ Makefile found"

# Check Dockerfiles
for service in nginx wordpress mariadb; do
    if [ ! -f "srcs/requirements/$service/Dockerfile" ]; then
        echo "❌ Dockerfile not found for $service"
        exit 1
    fi
    echo "✅ Dockerfile found for $service"
done

echo
echo "=== All checks passed! ==="
echo "You can now run: make all"
echo "Then access: https://geonwkim.42.fr" 