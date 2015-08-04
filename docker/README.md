Documentation
=============

This is about how to install Docker on a Debian.

Install docker.io
-----------------
First of all, we need to install Docker on the hosting machine.

    $ sudo apt-get install docker.io

In order to use Docker as a normal user (and not as root), you need to add your
user ID in the `docker` group.

    $ sudo adduser jsimard docker

You'll probably need to logout and login for updating groups.  You can also
(only temporary in your terminal), do a `su -l your_uid`.  To check if you're in
the `docker` group, use the `groups` command, it will display all the groups
you're in.

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
