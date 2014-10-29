Documentation
=============

This docker is about configuring a Skype instance which will run inside a
container.  The configuration of sound and video will be taken care of.  For the
sake of the explanation, I'll try to precise if the commands are for the hosting
machine or for the container.

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

Now, we will build the docker image with the `Dockerfile` file.  These file is
based on solution of [`Terr`](https://github.com/Terr/docker-skype-pulseaudio)
which is itself mainly based on solution of
[`tomparys`](https://github.com/tomparys/docker-skype-pulseaudio).  We will
build the image and give it the name `skype`.

    $ docker build -t skype - < Dockerfile

If you look into this file, you'll see that it installs PulseAudio and drivers
for camera.  It also creates a `skype` user with the same password.  Finally, it
creates a script to launch Skype which contains a few variables for
configuration.  `PULSE_SERVER` to redirect the sound; `PULSE_LATENCY_MSEC`to
solve a
[problem](https://wiki.debian.org/skype#Frequently_Ask_Questions_.28F.A.Q..29_for_64_bits)
with sound; `LD_PRELOAD` to solve a
[problem](https://wiki.debian.org/skype#Frequently_Ask_Questions_.28F.A.Q..29_for_64_bits)
with camera.

Install PulseAudio
------------------

On the host machine, we need to install PulseAudio because it will act as a
server; the docker container will forward sounds to this server.  [Colin
Guthrie](http://lists.freedesktop.org/archives/pulseaudio-discuss/2011-May/009997.html)
give some help about having PulseAudio works on a Debian with `systemd`.  First
of all, install PulseAudio.

    $ sudo apt-get install pulseaudio

You can check if it's running by using the following command (it should output
something).

    $ xprop -root | grep PULSE_COOKIE

If it doesn't run, then run it (or reboot the computer, it should work too).

    $ start-pulseaudio-x11

We also need to ensure that the TCP native protocole module is loaded.  To
check, use the following command (it should output something).

    $ pacmd list-modules | grep module-native-protocol-tcp

To start it, use this.

    $ pactl load-module module-native-protocol-tcp

It should be OK now.

Run the container
-----------------

You can start the container with the following command

    $ docker run -d -p 55555:22 --device=/dev/video0 skype

See that we are binding the camera with `--device` (thanks to
[`Terr`](https://github.com/Terr/docker-skype-pulseaudio)).

Configure SSH access
--------------------

You will connect to the container with a few parameters like a forward of a
port, X11 activated, etc.  You can put the following configuration into your
`~/.ssh/config` file.

    Host          skype-docker
    User          skype
    Port          55555
    HostName      127.0.0.1
    RemoteForward 64713 localhost:4713
    ForwardX11    yes

You can now connect to the container using the password `skype` (see the
`Dockerfile`).

    $ ssh skype-docker

You may copy your SSH keys to avoid to type the password each time you connect.
You can also run directly the Skype software by calling the created binary.

    $ ssh skype-docker skype-pulseaudio
