FROM ubuntu:latest
MAINTAINER chris@cbrgm.de

ENV SERVER_ADMIN 0

# CREATING DOCKER USER

# Add non privileged user
RUN groupadd -r avorion && \
	useradd -r -g avorion -d /home/avorion -s /sbin/nologin -c "Docker image user" avorion

# Set the home directory to our docker user's home.
ENV HOME=/home/avorion
ENV APP_HOME=/home/avorion/

# SETTING UP THE DOCKER IMAGE
WORKDIR $APP_HOME

# Install dependencies
RUN apt-get update -yq && apt-get -yq install wget lib32gcc1 

# Install steamcmd
RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz
RUN mkdir ./bin && tar -zxf steamcmd_linux.tar.gz -C ./bin
RUN rm -rf steamcmd_linux.tar.gz

# Download latest avorion server
RUN mkdir -p server
RUN mkdir -p server/galaxy/world
RUN bin/steamcmd.sh \
	+login anonymous \
	+force_install_dir /home/avorion/server \
	+app_update 565060 validate \
	+quit

# Expose ports and create volume

EXPOSE 27000 27000/udp
EXPOSE 27003 27003/udp
EXPOSE 27020 27020/udp
EXPOSE 27021 27020/udp

# Chown all files to unpriviliged user
RUN chown -R avorion:avorion $APP_HOME

# Change standard user
USER avorion

# Start server on container startup
#CMD server/server.sh --galaxy-name world --admin $SERVER_ADMIN --datapath galaxy/

