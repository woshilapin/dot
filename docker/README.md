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
