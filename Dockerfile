FROM ubuntu:latest
MAINTAINER chris@cbrgm.de

ENV SERVER_ADMIN 0

WORKDIR /avorion

# Install dependencies
RUN apt-get update -yq && apt-get -yq install wget lib32gcc1 

# Install steamcmd
RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
RUN mkdir ./bin && tar -zxf steamcmd_linux.tar.gz -C ./bin
RUN rm -rf steamcmd_linux.tar.gz

# Download latest avorion server
RUN mkdir -p server
RUN bin/steamcmd.sh \
	+login anonymous \
	+force_install_dir /avorion/server \
	+app_update 565060 validate \
	+quit

# Expose ports and create volume

EXPOSE 27000 27000/udp
EXPOSE 27003 27003/udp
EXPOSE 27020
EXPOSE 27021

# Start server on container startup
CMD server/server.sh --galaxy-name world --admin $SERVER_ADMIN --datapath galaxy/

