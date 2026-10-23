# iTop

Run [iTop](https://www.itophub.io) in a Docker container based on the [php:apache](https://hub.docker.com/_/php/) image.

[![Docker Pulls](https://img.shields.io/docker/pulls/supervisions/itop) ![Docker Stars](https://img.shields.io/docker/stars/supervisions/itop) ![Docker Image Size](https://img.shields.io/docker/image-size/supervisions/itop/latest)](https://hub.docker.com/r/supervisions/itop)

## Usage

Run the latest version (see [tags](#tags) for other iTop versions) container named **my-itop**:

```shell
docker run -d -p 80:80 --name=my-itop supervisions/itop:latest
```

Then go to http://localhost/ to start the installation wizard.

### Scheduling cron.php

In order to operate properly, iTop maintenance operations and asynchronous tasks must be executed on a regular basis.
In order to ease the installation, all the background tasks have been grouped to be launched from a single file.
The command to run this from your scheduler looks like this:

```shell
docker exec -u www-data my-itop php webservices/cron.php --auth_user=<login> --auth_pwd=<password>
```

If you don't want these credentials to be present in your scheduler, you can create a file `/etc/itop/cron.params` based on the file `webservices/cron.distrib` which can be used as a template.
The command to run from your scheduler then becomes this:

```shell
docker exec -u www-data my-itop php webservices/cron.php --param_file=/etc/itop/cron.params
```

### Docker Compose

A minimal setup with MariaDB and the cron task runner:

```yaml
services:
  itop:
    image: supervisions/itop:3.3
    pull_policy: weekly
    volumes:
      - itop-conf:/var/www/html/conf
      - itop-data:/var/www/html/data
      - itop-env:/var/www/html/env-production
    ports:
      - "[::1]:80:80" # only listen on localhost
    depends_on:
      db:
        condition: service_healthy
  db:
    image: mariadb
    environment:
      MARIADB_DATABASE: itop
      MARIADB_USER: ${MARIADB_USER:-itop}
      MARIADB_PASSWORD: ${MARIADB_PASS:-itop}
      MARIADB_ALLOW_EMPTY_ROOT_PASSWORD: 1
    healthcheck:
      test: [CMD, healthcheck.sh, --connect, --innodb_initialized]
      start_period: 10s
      interval: 10s
      timeout: 5s
      retries: 3
    volumes:
      - db-data:/var/lib/mysql
  cron:
    image: supervisions/itop:3.3
    pull_policy: weekly
    restart: unless-stopped
    environment:
      AUTH_USER: ${CRON_USER:-admin}
      AUTH_PWD: ${CRON_PASS:-admin}
    volumes:
      - itop-conf:/var/www/html/conf
      - itop-data:/var/www/html/data
      - itop-env:/var/www/html/env-production
    user: www-data
    entrypoint: [sh, -c]
    command:
      - php webservices/cron.php --auth_user="$${AUTH_USER}" --auth_pwd="$${AUTH_PWD}"
    depends_on:
      db:
        condition: service_healthy

volumes:
  db-data:
  itop-conf:
  itop-data:
  itop-env:
```

Start it with `docker compose up -d`, open http://localhost/ and run the setup wizard.
Use `db` as the database host, enter the username and password, and select the `itop` database.
Set `CRON_USER` and `CRON_PASS` in a `.env` file to an iTop account with the Administrator profile.

Example `.env` file:

```ini
MARIADB_USER=itop
MARIADB_PASS=change-me
CRON_USER=cron
CRON_PASS=change-me
```

## Tags

* `3.3.0`, `3.3`, `latest`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_3_0:release:change_log#section330)
* `3.2.3`, `3.2`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log#section3232)
* `2.7.13`, `2.7`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section2713)
* `3.2.2`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log#section3221)
* `3.2.1`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log#section3211)
* `3.1.3`, `3.1`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_1_0:release:change_log#section313)
* `2.7.12`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section2712)
* `3.1.2`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_1_0:release:change_log#section312)
* `2.7.11`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section2711)
* `3.2.0`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log#section320)
* `3.0.4`, `3.0`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log#section304)
* `2.7.10`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section2710)
* `3.1.1`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_1_0:release:change_log#section311)
* `2.7.9`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section279)
* `3.1.0`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_1_0:release:change_log#section310)
* `3.0.3`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log#section303)
* `2.7.8`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section278)
* `3.0.2`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log#section302)
* `2.7.7`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section277)
* `3.0.1`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log#section301)
* `3.0.0`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_0_0:release:change_log#section300)
* `2.7.6`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section276)
* `2.7.5`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section275)
* `2.7.4`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section274)
* `2.7.3`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section273)
* `2.7.2`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section272)
* `2.7.1`
[(Readme)](https://github.com/Combodo/iTop/blob/2.7.1/README.md)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section271)
* `2.7.0`
[(Readme)](https://github.com/Combodo/iTop/blob/2.7.0-2/README.md)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_7_0:release:change_log#section270)
* `2.6.3`, `2.6`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_6_0:release:change_log#section263)
* `2.6.1`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_6_0:release:change_log#section261)
* `2.6.0`
[(Changelog)](https://www.itophub.io/wiki/page?id=2_6_0:release:change_log#section260)
* `2.5.1`, `2.5`
[(Readme)](https://github.com/Combodo/iTop/blob/2.5.1/readme.txt)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_5_0:release:change_log#section251)
* `2.5.0`
[(Readme)](https://github.com/Combodo/iTop/blob/2.5.0/readme.txt)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_5_0:release:change_log#section250)
* `2.4.3`, `2.4`
[(Readme)](https://github.com/Combodo/iTop/blob/2.4.3/readme.txt)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_4_0:release:change_log#section243)
* `2.4.1`
[(Readme)](https://github.com/Combodo/iTop/blob/2.4.1/readme.txt)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_4_0:release:change_log#section241)
* `2.4.0`
[(Readme)](https://github.com/Combodo/iTop/blob/2.4.0/readme.txt)
[(Changelog)](https://www.itophub.io/wiki/page?id=2_4_0:release:change_log#section240)
* `2.3.4`, `2.3` [(Readme)](https://github.com/Combodo/iTop/blob/2.3.4/readme.txt)
* `2.3.3` [(Readme)](https://github.com/Combodo/iTop/blob/2.3.3/readme.txt)
