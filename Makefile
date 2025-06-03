.PHONY:    all build up down clean fclean re

all:    build up

build:
	cd srcs && docker compose build

up:
	cd srcs && docker compose up -d

down:
	cd srcs && docker compose down

clean:    down

fclean:    down
	cd srcs && docker system prune -af
	cd srcs && docker volume prune -f

re:    fclean build up