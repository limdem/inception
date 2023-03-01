all:
	docker compose -p inception -f srcs/docker-compose.yml up -d

build:
	docker compose -p inception -f srcs/docker-compose.yml build

start:
	docker compose -p inception -f srcs/docker-compose.yml start

stop:
	docker compose -p inception -f srcs/docker-compose.yml stop

down:
	docker compose -p inception -f srcs/docker-compose.yml down 

re:
	docker compose -p inception -f srcs/docker-compose.yml up -d

clean:
	docker compose -p inception -f srcs/docker-compose.yml down --volumes
	docker compose -p inception -f srcs/docker-compose.yml rm --force --stop --volumes
