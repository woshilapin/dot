FROM debian:testing
MAINTAINER woshilapin "woshilapin@gmail.com"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

# Setup multiarch because Skype is 32bit only
RUN dpkg --add-architecture i386

# Make sure the repository information is up to date
RUN apt-get update

# We need ssh to access the docker container, wget to download skype
RUN apt-get install -y openssh-server wget libpulse0:i386 libv4l-0:i386

# Install Skype
RUN wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
RUN dpkg -i skype-install.deb || true
RUN apt-get install -fy						# Automatically detect and install dependencies

# Set the password of "skype"
RUN useradd -G video -m -d /home/skype skype
RUN echo "skype:skype" | chpasswd

# Create OpenSSH privilege separation directory, enable X11Forwarding
RUN mkdir -p /var/run/sshd

# Set locale (fix locale warnings)
RUN localedef -v -c -i fr_FR -f UTF-8 fr_FR.UTF-8 || true
RUN echo "Europe/Paris" > /etc/timezone

# Set up the launch wrapper - sets up PulseAudio to work correctly
RUN echo '' >> /usr/local/bin/skype-pulseaudio
RUN echo 'PULSE_SERVER="tcp:localhost:64713" PULSE_LATENCY_MSEC=60 LD_PRELOAD=/usr/lib/i386-linux-gnu/libv4l/v4l1compat.so skype' >> /usr/local/bin/skype-pulseaudio
RUN chmod 755 /usr/local/bin/skype-pulseaudio

# Expose the SSH port
EXPOSE 22

# Start SSH
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]
