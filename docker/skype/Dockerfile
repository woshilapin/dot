# Inspired by https://github.com/tomparys/docker-skype-pulseaudio
FROM debian:latest
MAINTAINER woshilapin "woshilapin@tuziwo.info"

RUN useradd -u 1000 -d /home/skype -m -s /bin/bash skype

# Set locale (fix locale warnings)
# https://stackoverflow.com/questions/26473819/change-ubuntu-locale-in-docker
RUN apt-get update && \
	apt-get install --assume-yes --no-install-recommends \
	locales
RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8
RUN localedef -v -c -i fr_FR -f UTF-8 fr_FR.UTF-8 || true
# Set the timezone properly
# https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes/683651#683651
ENV TZ Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setup multiarch because Skype is 32bit only
RUN dpkg --add-architecture i386

# Make sure the repository information is up to date
RUN apt-get update && \
	apt-get install --assume-yes --no-install-recommends \
	libpulse0:i386 \
	libv4l-0:i386 \
	wget

# Install Skype
RUN wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
RUN dpkg -i skype-install.deb || true
# Automatically detect and install dependencies
RUN apt-get install --fix-broken --assume-yes

# Set up the launch wrapper - sets up PulseAudio to work correctly
# https://github.com/terlar/docker-spotify-pulseaudio
RUN echo enable-shm=no >> /etc/pulse/client.conf
# https://wiki.debian.org/skype#Frequently_Ask_Questions_.28F.A.Q..29_for_64_bits
ENV PULSE_SERVER /run/pulse/native
ENV PULSE_LATENCY_MSEC 60

# Persistence of data should happen in /home/skype/.Skype
# For an unknown reason, it seems that using /home/skype/.Skype make Skype
#complaining about a concurrent access to the folder.
# Using the all user folder fix the problem
VOLUME /home/skype

USER skype
