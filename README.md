# Avorion Server using Docker


![Avorion](https://i2.wp.com/bigbossbattle.com/wp-content/uploads/2017/01/logo_done.png?w=705&ssl=1)
![Docker](https://raw.githubusercontent.com/github/explore/6c6508f34230f0ac0d49e847a326429eefbfc030/topics/docker/docker.png)

## Description

You want to host your own dedicated Avorion Server? Best in a docker container? Then you've come to the right place!

This small side project of mine provides a `Dockerfile` that will always install and update to the latest `steamcmd` and [Avorion][61e6a3c0] server files. The entire server runs inside a docker container and allows you to easily play with your friends or host a public server. The server can easily be updated and managed by using `make`.

[61e6a3c0]: http://store.steampowered.com/app/445220/Avorion/ "avorion"

## Setting up the Server

Follow the steps to get startet!

#### Step 1: Clone the repository!

Clone this repository and its content using

```bash
git clone https://github.com/cbrgm/7days-docker
```

#### Step 2: Create an up-to-date image of avorion-server

In the directory type the following `make` command to build an image with the latest server files for your docker container

```bash
make build
```

This will automatically create two additional folders `world` and `backup`. The `world` folder will be mounted inside the container and will persist all server data. You can easily create a backup of them by simply copying the folders content. The `backup` folder will be used for backup data saves.

#### Step 3: Run your server

Start your server, so it will generate all server files into `world` folder. **Important**: Add your steam id or the steam id of your server administrator before running the container!

```bash
make run ADMIN=<Steam_id>
```

#### Step 4: Adjust settings and join server!

Stop the container first (`make stop`). In your `world` folder adjust the `server.ini` and change to values. An explanation of each parameter can be found on the web. Start your container after changing your `server.ini` and start playing!

You can now connect to your server using **yourserver-ip/domain** at the Avorion Multiplayer menu. Congratulations! :-)

## Administrating / Backup

#### Starting the server

To start the server use:

```bash
make start
```

#### Stopping the server

To stop the server use:

```bash
make stop
```

#### Restarting the server

To restart the server use:

```bash
make restart
```

#### Get the logs of the servers console

To get the logs of the server use:

```bash
make logs
```

#### Create Backup of your galaxy data!

This will copy the folder `world` to the `backup` directory with format "year-month-date-backup".

```bash
make backup
```

### Updating the server

Once a new version of Avorion is released you can easily upgrade your server with the latest server files.
Do the following

-   Perform a backup of your world data (`make backup`)
-   Stop, remove and delete your docker container and image
    -   `docker stop avorion-docker`
    -   `docker rm avorion-docker`
    -   `docker rmi avorion-server`
-   Repeat the installation steps explaned above
-   Copy your backup from `backup` back into `world` folder
-   Done!

## Feature Request and Contributing

You have suggestions for improvements or features you miss? You are welcome to express all your wishes here. Just create a new [Issue][e872f832] and it will be taken care of quickly!

[e872f832]: https://github.com/cbrgm/avorion-docker/issues "avorion issues"

## Motivation

This script was originally developed by [Christian Bargmann][b9824663]. I wanted to play Avorion together with some friends, this is about how I ended up :-)

[b9824663]: http://cbrgm.de "blog"
