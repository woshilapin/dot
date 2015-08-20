Cozy docker
===========

Cozy has been split into multiple services.  In order to run them all, you can
use [`docker-compose`](https://docs.docker.com/compose/).  Install it and then,
run the following command from the same folder than contains
`docker-compose.yml`.

    docker-compose up

It will build every image so it may take a while.  Once done, you'll have to
initialize the controller of Cozy.

    docker exec cozy_controller_1 cozy-init.sh

Please be sure that your image is called `cozy_controller_1` using `docker ps`.

# Install `docker-compose`
In order to install `docker-compose`, execute the following command with root
privilege.

    curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
