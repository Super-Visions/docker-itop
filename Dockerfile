FROM php:apache

# install extra packages
RUN apt-get update \
	&& apt-get install -y \
		graphviz \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libldap2-dev \
		libmcrypt-dev \
		libpng12-dev \
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
		libjpeg62-turbo-dev \
		libldap2-dev \
		libmcrypt-dev \
		libpng12-dev \
		libxml2-dev \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

# Load iTop files
RUN curl -L -o /tmp/iTop.zip https://sourceforge.net/projects/itop/files/itop/2.3.3/iTop-2.3.3-3159.zip \
	&& unzip /tmp/iTop.zip -d /tmp/ web/* \
	&& mv -v /tmp/web/* /var/www/html/ \
	&& chown -R www-data: /var/www/html/ \
	&& rm -rf /tmp/iTop.zip /tmp/web

# Add default configuration
COPY config-itop.php /etc/itop/production/config-itop.php
RUN ln -s /etc/itop /var/www/html/conf \
	&& chown -R www-data: /etc/itop

ENV DB_HOSTNAME="db" DB_PREFIX=""
