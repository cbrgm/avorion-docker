SHELL := /bin/bash

build:
	mkdir -p world backup
	docker build --tag "avorion-server:latest" .

run:
	docker run -itd --name "avorion-docker" -e SERVER_ADMIN=$(ADMIN) -v `pwd`/world:/avorion/server/galaxy/world -p 27000:27000 -p 27000:27000/udp -p 27003:27003 -p 27003:27003/udp -p 27020:27020 -p 27020:27020/udp -p 27021:27021 -p 27021:27021/udp avorion-server:latest

stop:
	echo "Stopping Avorion Server..."
	docker stop avorion-docker

start:
	echo "Starting Avorion Server..."
	docker start avorion-docker

restart:
	echo "Restarting Avorion Server, please wait..."
	docker restart avorion-docker

backup:
	echo "Creating Backup of Avorion Server, Server will be stopped if running..."
	docker stop avorion-docker
	mkdir -p backup/$$(date +%Y-%d-%m)-backup
	cp -r world/* backup/$$(date +%Y-%d-%m)-backup 
	echo "Backup successfully saved in backups folder!"

logs:
	docker logs avorion-docker
