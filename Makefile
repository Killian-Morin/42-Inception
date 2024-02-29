NAME = inception

# The only thing to change if you want to use this project (normally)
LOGIN = kmorin

RESET = \033[0m
BLUE = \033[0;34m
GREEN = \033[0;92m
CYAN = \033[0;96m
MAGENTA = \033[0;95m

# Determine the OS under which we are running
# Set the home directory accodingly (/Users/login if on MacOS, /home/login if on Linux)
# Set the domaine name accordingly
ifeq ($(shell uname),Darwin)
	HOME = /Users/$(LOGIN)
	export STUDENT_DOMAIN = localhost
else
	HOME = /home/$(LOGIN)
	export STUDENT_DOMAIN = $(LOGIN).42.ch
endif

# Use the HOME path to sets the paths of the volumes
export WORDPRESS_VOL := $(HOME)/data/wordpress
export MARIADB_VOL := $(HOME)/data/mariadb

all: build up

# Create the directories for the volumes
build:
	mkdir -p ${MARIADB_VOL};
	mkdir -p ${WORDPRESS_VOL};

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
	-if [ "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	rm -rf ${MARIADB_VOL}
	rm -rf ${WORDPRESS_VOL}

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