all: up

build:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build
#docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build --parallel

up: build
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

start:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env start

stop:
	docker-compose -f srcs/docker-compose.yml stop

down:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v

clear:
	-if [ "$$(docker ps -q)" ]; then docker stop $$(docker ps -qa); fi
	-if	[ "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); fi
	-if	[ "$$(docker images -q)" ]; then docker rmi -f $$(docker images -qa);	fi
	-if	[ "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	-if	[ "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q) 2>/dev/null; fi

.PHONY: all clean