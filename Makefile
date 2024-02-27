NAME = inception
MARIADB_VOL = 0
WORDPRESS_VOL = 0

RESET = \033[0m
BLUE = \033[0;34m
GREEN = \033[0;92m
CYAN = \033[0;96m
MAGENTA = \033[0;95m

all: build up

build:
# create the folders for the volumes is they do not exist yet (remember to change the login)
# on the VM (the path is given in the subject)
	# if [ ! -d /home/login/data/wordpress ]; then \
	# 	mkdir -p /home/login/data/wordpress; \
	# fi
	# if [ ! -d /home/login/data/mariadb ]; then \
	# 	mkdir -p /home/login/data/mariadb; \
	# fi
# on the "normal" host
	# if [ ! -d /Users/login/data/wordpress ]; then \
	# 	mkdir -p /Users/login/data/wordpress; \
	# fi
	# if [ ! -d /Users/login/data/mariadb ]; then \
	# 	mkdir -p /Users/login/data/mariadb; \
	# fi

	@if [ -d /Users ]; then \ # check if on macos or Debian and set the volumes path variables accordingly
		MARIADB_VOL = /Users/login/data/mariadb; \ # paths that you can choose
		WORDPRESS_VOL = /Users/login/data/wordpress; \
	else \ # no /Users folder so on Debian, so on the VM (for me), so use the paths given in the subject
		MARIADB_VOL = /home/login/data/mariadb; \
		WORDPRESS_VOL = /home/login/data/wordpress; \
	fi

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

# remove the folders used for the volumes (remember to change the login)
# on the VM
	# rm -rf /home/login/data/mariadb
	# rm -rf /home/login/data/wordpress
# on the "normal" host
	# rm -rf /Users/login/data/mariadb
	# rm -rf /Users/login/data/wordpress

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