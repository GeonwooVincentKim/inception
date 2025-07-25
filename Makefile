# Inception Project Makefile

NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml

.PHONY: all setup build up down clean fclean re logs

all: setup build up

setup:
	@echo "Setting up data directories..."
	mkdir -p /home/geonwkim/data/wordpress
	mkdir -p /home/geonwkim/data/mariadb
	@echo "Data directories created in /home/geonwkim/data/"

build:
	@echo "Building $(NAME) containers..."
	docker compose -f $(COMPOSE_FILE) build --quiet

build-verbose:
	@echo "Building $(NAME) containers (verbose)..."
	docker compose -f $(COMPOSE_FILE) build

up:
	@echo "Starting $(NAME) services..."
	docker compose -f $(COMPOSE_FILE) up -d

down:
	@echo "Stopping $(NAME) services..."
	docker compose -f $(COMPOSE_FILE) down

clean:
	@echo "Cleaning containers and images..."
	docker compose -f $(COMPOSE_FILE) down --rmi all --volumes --remove-orphans
	@echo "Removing data directories..."
	sudo rm -rf /home/geonwkim/data/wordpress/*
	sudo rm -rf /home/geonwkim/data/mariadb/*
	@echo "Volume contents cleaned!"

fclean: clean
	@echo "Full cleaning..."
	docker system prune -af

re: fclean all

logs:
	@echo "Showing logs..."
	docker compose -f $(COMPOSE_FILE) logs -f

status:
	@echo "Container status:"
	docker compose -f $(COMPOSE_FILE) ps

shell-nginx:
	docker exec -it nginx /bin/bash

shell-wordpress:
	docker exec -it wordpress /bin/bash

shell-mariadb:
	docker exec -it mariadb /bin/bash
