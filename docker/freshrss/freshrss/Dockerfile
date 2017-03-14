# VERSION 1.6.3
FROM php:5.6-apache
MAINTAINER woshilapin "woshilapin@tuziwo.info"
LABEL version="1.6.3"

# Install 'wget' and 'unzip' needed to download and extract Baikal sources
RUN DEBIAN_FRONTEND=noninteractive apt update -y && \
	apt upgrade -y && \
	apt install -y wget unzip libpq-dev

# Upload the Apache configuration file
ADD apache2.conf /etc/apache2/sites-enabled/000-default.conf

# Activate Rewrite engine needed in the configuration file
RUN a2enmod rewrite

# Install the 'postgresql' driver for php
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo_pgsql pgsql

# Install FreshRSS
RUN wget -O /var/www/freshrss.zip https://github.com/FreshRSS/FreshRSS/archive/1.6.3.zip
RUN wget -O /var/www/freshrss-extensions.zip https://github.com/FreshRSS/Extensions/archive/master.zip
RUN wget -O /var/www/freshrss-extension-youtube.zip https://github.com/kevinpapst/freshrss-youtube/archive/master.zip
RUN unzip -d /var/www/ /var/www/freshrss.zip
RUN unzip -d /var/www/ /var/www/freshrss-extensions.zip
RUN unzip -d /var/www/ /var/www/freshrss-extension-youtube.zip
RUN mv /var/www/freshrss-youtube*/xExtension-YouTube /var/www/Extensions*/
RUN rm -rf /var/www/freshrss-youtube*
RUN mv /var/www/Extensions*/xExtension-* /var/www/FreshRSS*/extensions/
RUN rm -rf /var/www/Extensions*
RUN mv /var/www/FreshRSS* /var/www/freshrss
RUN chown -R www-data:www-data /var/www/freshrss
