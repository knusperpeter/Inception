.PHONY:    all build up down clean fclean dead

all:    build up

build:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress
	cd srcs && docker compose build

up:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress
	cd srcs && docker compose up -d

down:
	cd srcs && docker compose down

clean:    down

fclean:    down
	cd srcs && docker system prune -af
	cd srcs && docker volume prune -f


dead:	fclean
	sudo rm -rf ~/data/mariadb/*
	sudo rm -rf ~/data/wordpress/*