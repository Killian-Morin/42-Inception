NAME = inception

all: build up

build:
	docker-compose -f srcs/docker-compose.yml -p ${NAME} build

up:
	docker-compose -f srcs/docker-compose.yml -p ${NAME} up -d

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

.PHONY: all clean