NAME	=	inception

all:		inception

${NAME}:	build


build:
		@mkdir -p /home/${USER}/data
		@mkdir -p /home/${USER}/data/db
		@mkdir -p /home/${USER}/data/wp
		@sudo chmod 777 /home/${USER}/data
		@docker compose -f srcs/docker-compose.yml build
		@docker compose -f srcs/docker-compose.yml up -d

down:
		@docker compose -f srcs/docker-compose.yml down

ps:
		@docker compose -f srcs/docker-compose.yml ps

stop:
		@docker compose -f srcs/docker-compose.yml stop

clean: down
		@docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker system prune -a --force

fclean: clean
		sudo rm -rf /home/${USER}/data/db
		sudo rm -rf /home/${USER}/data/wp

re:
		@mkdir -p /home/${USER}/data
		@mkdir -p /home/${USER}/data/db
		@mkdir -p /home/${USER}/data/wp
		@sudo chmod 777 /home/${USER}/data
		@docker compose -f srcs/docker-compose.yml build
		docker compose -f srcs/docker-compose.yml up

.PHONY: all build up down ps stop clean re
	
