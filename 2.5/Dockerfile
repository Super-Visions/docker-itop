FROM php:7.1-apache

# install extra packages
RUN apt-get update \
	&& apt-get install -y \
		graphviz \
		libfreetype6-dev \
		libjpeg-dev \
		libldap2-dev \
		libmcrypt-dev \
		libpng-dev \
		libxml2-dev \
		mariadb-client \
		unzip \
		zlib1g-dev \
	&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
	&& docker-php-ext-install \
		gd \
		ldap \
		mcrypt \
		mysqli \
		soap \
		zip \
	&& apt-get remove -y \
		libfreetype6-dev \
		libjpeg-dev \
		libldap2-dev \
		libmcrypt-dev \
		libpng-dev \
		libxml2-dev \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

# Load iTop files
RUN curl -L -o /tmp/iTop.zip https://sourceforge.net/projects/itop/files/itop/2.5.1/iTop-2.5.1-4123.zip \
	&& unzip /tmp/iTop.zip -d /tmp/ web/* \
	&& mv -v /tmp/web/* /var/www/html/ \
	&& chown -R www-data: /var/www/html/ \
	&& rm -rf /tmp/iTop.zip /tmp/web

# Add default configuration
COPY php.ini /usr/local/etc/php/php.ini
COPY config-itop.php /var/www/html/conf/production/config-itop.php
RUN chown -R www-data: /var/www/html/conf

ENV DB_HOSTNAME="db" DB_PREFIX=""
