FROM php:8.4-apache AS itop-src

# Install unzip package
# hadolint ignore=DL3008,DL3015
RUN apt-get update && apt-get install -y unzip

# Load version info from arguments
ARG release
ARG patch
ARG checksum

# Extract iTop files
ADD --checksum=${checksum} \
	https://github.com/Combodo/iTop/releases/download/${release}/iTop-${release}-${patch}.zip /tmp/iTop.zip
RUN unzip -q /tmp/iTop.zip -d /tmp/ \
	&& mkdir /tmp/web/env-production


FROM php:8.4-apache AS itop

# Add helper script
COPY --from=mlocati/php-extension-installer:latest /usr/bin/install-php-extensions /usr/local/bin/

# Install extra packages
# hadolint ignore=DL3008,DL3009
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		graphviz \
		mariadb-client \
	&& install-php-extensions \
		apcu \
		gd \
		ldap \
		mcrypt \
		mysqli \
		soap \
		zip

# Load iTop files
COPY --from=itop-src --chown=www-data:www-data /tmp/web/ /var/www/html/

# Add default configuration
COPY php.ini /usr/local/etc/php/php.ini
COPY --chown=www-data:www-data config-itop.php /var/www/html/conf/production/config-itop.php

# Add custom entrypoint
COPY docker-itop-entrypoint /usr/local/bin/
ENTRYPOINT ["docker-itop-entrypoint"]
CMD ["apache2-foreground"]

ENV DB_HOSTNAME="db" DB_PREFIX=""
VOLUME ["/var/www/html/conf", "/var/www/html/data", "/var/www/html/env-production", "/var/www/html/log"]
