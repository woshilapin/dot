# VERSION 0.4.6
FROM php:5.6-apache
MAINTAINER woshilapin "woshilapin@tuziwo.info"
LABEL version="1.6.2"

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
RUN wget -O /var/www/freshrss.zip https://github.com/FreshRSS/FreshRSS/archive/1.6.2.zip
RUN unzip -d /var/www/ /var/www/freshrss.zip
RUN mv /var/www/FreshRSS* /var/www/freshrss
RUN chown -R www-data:www-data /var/www/freshrss/data

