Documentation
=============

This is about how to install Docker on a Debian.

Install docker
--------------

Add the package repository first (see [documentation](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)).

    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    $ echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

First of all, we need to install Docker on the hosting machine.

    $ sudo apt update
    $ sudo apt install docker-ce docker-ce-cli

In order to use Docker as a normal user (and not as root), you need to add your
user ID in the `docker` group.

    $ sudo adduser jsimard docker

You'll probably need to logout and login for updating groups.  You can also
(only temporary in your terminal), do a `su -l your_uid`.  To check if you're in
the `docker` group, use the `groups` command, it will display all the groups
you're in.

Change default Docker folder
----------------------------

By default, Docker will store all the images, containers, volumes and a bunch
of metadata in `/var/lib/docker`. If your system on `/` is limited in disk
space (`/home` being mounted on another partition for example), this can become
a problem.

You can create a `docker` user with its own `/home/docker` folder that will be
used. The `docker` use will be associated with the existing `docker` group
(created during installation of Docker).

```sh
sudo adduser \
  --home /home/docker \
  --disabled-login \
  --disabled-password \
  --system \
  docker
sudo adduser docker docker # add user 'docker' to the group 'docker'
```

Then edit the file `/etc/docker/daemon.json` to add this configuration.

```json
{
    "data-root": "/home/docker"
}
```

Clean volumes
-------------
Volumes can be created with containers.  They allow you to get some persistence.
When you delete containers, volumes are preserved.  However, once a container is
deleted, it's hard to get back links towards a volume.  And for example, it's
difficult to delete them.

To do that, you can use the [`docker-cleanup-volumes.sh`
script](https://github.com/chadoe/docker-cleanup-volumes).  It will remove all
the volumes that are not related to any containers.  Note that this script must
be launched with root permissions.

```
sudo docker-cleanup-volumes.sh
```

In order to simulate the actions that will be triggered, you may run it first
with a `--dry-run` option.
