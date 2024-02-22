NAME = inception

RESET = \033[0m
BLUE = \033[0;34m
GREEN = \033[0;92m
CYAN = \033[0;96m
MAGENTA = \033[0;95m

all: build up

build:
	if [ ! -d /Users/kmorin/data/wordpress ]; then \
		mkdir -p /Users/kmorin/data/wordpress; \
	fi
	if [ ! -d /Users/kmorin/data/mariadb ]; then \
		mkdir -p /Users/kmorin/data/mariadb; \
	fi
	docker-compose -f srcs/docker-compose.yml -p ${NAME} build

up:
	docker-compose -f srcs/docker-compose.yml -p ${NAME} up

start:
	docker-compose -f srcs/docker-compose.yml -p ${NAME} start

stop:
	docker-compose -f srcs/docker-compose.yml -p ${NAME} stop

down:
	docker-compose -f srcs/docker-compose.yml -p ${NAME} down

clear:
	-if [ "$$(docker ps -q)" ]; then docker stop $$(docker ps -qa); fi
	-if	[ "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	-if	[ "$$(docker images -q)" ]; then docker rmi -f $$(docker images -qa);	fi
	-if	[ "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	-if	[ "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q) 2>/dev/null; fi

clean: down
	docker system prune -a
	rm -rf /Users/kmorin/data/mariadb
	rm -rf /Users/kmorin/data/wordpress
	docker volume rm mariadb_vol wordpress_vol

status:
	@echo "${BLUE}Status:"
	@docker ps -a
	@echo "${RESET}"

	@echo "${GREEN}Images:"
	@docker image ls -a
	@echo "${RESET}"

	@echo "${CYAN}Containers:"
	@docker container ls -a
	@echo "${RESET}"

	@echo "${MAGENTA}Volumes:"
	@docker volume ls
	@echo "${RESET}"

.PHONY: all build up start stop down clear clean status