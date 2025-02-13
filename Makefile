# Variables
DATA_PATH = /home/${USER}/data
WORDPRESS_PATH = ${DATA_PATH}/wordpress
MARIADB_PATH = ${DATA_PATH}/mariadb
COMPOSE_FILE = srcs/docker-compose.yml

# Colors for output
GREEN = \033[0;32m
YELLOW = \033[1;33m
NC = \033[0m

# Main targets
all: setup build

# Create necessary directories and set permissions
setup:
	@echo "${GREEN}Creating data directories...${NC}"
	@sudo mkdir -p ${WORDPRESS_PATH}
	@sudo mkdir -p ${MARIADB_PATH}
	@sudo chmod 755 ${DATA_PATH}
	@sudo chmod 755 ${WORDPRESS_PATH}
	@sudo chmod 755 ${MARIADB_PATH}
	@sudo chown -R ${USER}:${USER} ${DATA_PATH}
	@echo "${GREEN}Directories created and permissions set${NC}"

# Clean existing containers
preclean:
	@echo "${YELLOW}Cleaning up existing containers...${NC}"
	@docker stop mariadb wordpress nginx 2>/dev/null || true
	@docker rm mariadb wordpress nginx 2>/dev/null || true
	@echo "${GREEN}Existing containers cleaned${NC}"

# Build and start containers
build: preclean
	@echo "${GREEN}Building and starting containers...${NC}"
	@docker-compose -f ${COMPOSE_FILE} up --build -d

# Stop containers
stop:
	@echo "${GREEN}Stopping containers...${NC}"
	@docker-compose -f ${COMPOSE_FILE} stop

# Start containers
start:
	@echo "${GREEN}Starting containers...${NC}"
	@docker-compose -f ${COMPOSE_FILE} start

# Remove containers and networks
down:
	@echo "${GREEN}Removing containers and networks...${NC}"
	@docker-compose -f ${COMPOSE_FILE} down

# Deep clean (containers, networks, volumes, images)
fclean: down
	@echo "${YELLOW}Performing deep clean...${NC}"
	@docker stop $$(docker ps -a -q) 2>/dev/null || true
	@docker rm $$(docker ps -a -q) 2>/dev/null || true
	@docker rmi $$(docker images -a -q) 2>/dev/null || true
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network prune -f 2>/dev/null || true
	@sudo rm -rf ${DATA_PATH}
	@echo "${GREEN}Deep clean complete${NC}"

# Rebuild everything from scratch
re: fclean all

# Show container status
status:
	@echo "${GREEN}Container Status:${NC}"
	@docker ps -a
	@echo "\n${GREEN}Volume Status:${NC}"
	@docker volume ls
	@echo "\n${GREEN}Network Status:${NC}"
	@docker network ls

.PHONY: all setup preclean build stop start down fclean re status