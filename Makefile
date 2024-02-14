all:
	docker-compose run

clean:
	docker-compose down

.PHONY: all clean