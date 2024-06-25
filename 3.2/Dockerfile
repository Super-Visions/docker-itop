FROM php:8.3-apache

# Load version info from arguments
ARG release
ARG patch

# Add helper script
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install extra packages
# hadolint ignore=DL3008,DL3009
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		graphviz \
		mariadb-client \
		unzip \
	&& chmod uga+x /usr/local/bin/install-php-extensions \
	&& install-php-extensions \
		apcu \
		gd \
		ldap \
		mcrypt \
		mysqli \
		soap \
		zip

# Load iTop files
RUN curl -L -o /tmp/iTop.zip https://sourceforge.net/projects/itop/files/itop/${release}/iTop-${release}-${patch}.zip \
	&& unzip /tmp/iTop.zip -d /tmp/ web/* \
	&& mv -v /tmp/web/* /var/www/html/ \
	&& mkdir /var/www/html/env-production \
	&& chown -R www-data: /var/www/html/ \
	&& rm -rf /tmp/iTop.zip /tmp/web

# Add default configuration
COPY php.ini /usr/local/etc/php/php.ini
COPY config-itop.php /var/www/html/conf/production/config-itop.php
RUN chown -R www-data: /var/www/html/conf

# Add custom entrypoint
COPY docker-itop-entrypoint /usr/local/bin/
ENTRYPOINT ["docker-itop-entrypoint"]
CMD ["apache2-foreground"]

ENV DB_HOSTNAME="db" DB_PREFIX=""
VOLUME ["/var/www/html/conf", "/var/www/html/data", "/var/www/html/env-production", "/var/www/html/log"]
