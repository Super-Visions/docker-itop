FROM php:8.1-apache

# load version info from arguments
ARG release
ARG patch

# add helper script
COPY --from=mlocati/php-extension-installer:latest /usr/bin/install-php-extensions /usr/local/bin/

# install extra packages
# hadolint ignore=DL3008,DL3009
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		graphviz \
		mariadb-client \
		unzip \
	&& install-php-extensions \
		apcu \
		gd \
		imap \
		ldap \
		mcrypt \
		mysqli \
		soap \
		zip

# Load iTop files
COPY ["files/iTop Professional-${release}-${patch}.zip", "/tmp/iTop.zip"]
RUN unzip /tmp/iTop.zip -d /tmp/ web/* \
	&& mv -v /tmp/web/* /var/www/html/ \
	&& mkdir /var/www/html/env-production \
	&& chown -R www-data: /var/www/html/ \
	&& rm -rf /tmp/iTop.zip /tmp/web

# Add default configuration
COPY php.ini /usr/local/etc/php/php.ini

# Add custom entrypoint
COPY docker-itop-entrypoint /usr/local/bin/
ENTRYPOINT ["docker-itop-entrypoint"]
CMD ["apache2-foreground"]

VOLUME ["/var/www/html/conf", "/var/www/html/data", "/var/www/html/env-production", "/var/www/html/log"]
