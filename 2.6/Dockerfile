FROM php:7.2-apache

# Add helper script
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install extra packages
RUN apt-get update \
	&& apt-get install -y \
		graphviz \
		mariadb-client \
		unzip \
	&& chmod uga+x /usr/local/bin/install-php-extensions \
	&& install-php-extensions \
		gd \
		ldap \
		mcrypt \
		mysqli \
		soap \
		zip 

# Load iTop files
RUN curl -L -o /tmp/iTop.zip https://sourceforge.net/projects/itop/files/itop/2.6.3/iTop-2.6.3-5092.zip \
	&& unzip /tmp/iTop.zip -d /tmp/ web/* \
	&& mv -v /tmp/web/* /var/www/html/ \
	&& mkdir /var/www/html/env-production \
	&& chown -R www-data: /var/www/html/ \
	&& rm -rf /tmp/iTop.zip /tmp/web

# Add default configuration
COPY php.ini /usr/local/etc/php/php.ini
COPY config-itop.php /var/www/html/conf/production/config-itop.php
RUN chown -R www-data: /var/www/html/conf

ENV DB_HOSTNAME="db" DB_PREFIX=""
VOLUME ["/var/www/html/conf", "/var/www/html/data", "/var/www/html/env-production", "/var/www/html/log"]
