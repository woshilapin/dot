# VERSION 0.4.6
FROM php:5.6-apache
MAINTAINER woshilapin "woshilapin@tuziwo.info"
LABEL version="0.4.6"

# Install 'wget' and 'unzip' needed to download and extract Baikal sources
RUN DEBIAN_FRONTEND=noninteractive apt update -y && \
	apt upgrade -y && \
	apt install -y wget unzip

# Upload the Apache configuration file
ADD apache2.conf /etc/apache2/sites-enabled/000-default.conf

# Activate Rewrite engine needed in the configuration file
RUN a2enmod rewrite

# Install the 'mysql' driver for php
RUN docker-php-ext-install pdo_mysql

# Install Baikal
RUN wget -O /var/www/baikal.zip https://github.com/fruux/Baikal/releases/download/0.4.6/baikal-0.4.6.zip
RUN unzip -d /var/www/ /var/www/baikal.zip
RUN chown -R www-data:www-data /var/www/baikal/Specific

