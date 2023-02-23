NAME	=	inception

all:		inception

${NAME}:	build up

build:
		@docker compose -f srcs/docker-compose.yml build

up:
		@rm -rf /home/${USER}/data
		@mkdir -p /home/${USER}/data
		@mkdir -p /home/${USER}/data/db
		@mkdir -p /home/${USER}/data/wp
		@docker-compose -f srcs/docker-compose.yml up -d

down:
		@docker-compose -f srcs/docker-compose.yml down

ps:
		@docker-compose -f srcs/docker-compose.yml ps

stop:
		@docker compose -f srcs/docker-compose.yml stop

clean: down
		@docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker system prune -a --force
		sudo rm -Rf /home/${USER}/data/db
		sudo rm -Rf /home/${USER}/data/wp
		mkdir /home/${USER}/data/db
		mkdir /home/${USER}/data/wp

re:
		@mkdir -p ../data/wp
		@mkdir -p ../data/db
		@docker-compose -f srcs/docker-compose.yml build
		docker-compose -f srcs/docker-compose.yml up

.PHONY: all build up down ps stop clean re
	