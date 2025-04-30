# iTop

Run [iTop](https://www.itophub.io) in a Docker container based on the [php:apache](https://hub.docker.com/_/php/) image.

[![Docker Pulls](https://img.shields.io/docker/pulls/supervisions/itop) ![Docker Stars](https://img.shields.io/docker/stars/supervisions/itop) ![Docker Image Size](https://img.shields.io/docker/image-size/supervisions/itop/latest)](https://hub.docker.com/r/supervisions/itop)

## Usage

Run the latest version (see tags for other iTop versions) container named **my-itop**:

```shell
docker run -d -p 80:80 --name=my-itop supervisions/itop:latest
```

Then go to [http://localhost/setup](http://localhost/setup) to continue the installation.
The setup can be preloaded with database credentials by linking to a MySQL/MariaDB container or by providing environment variables.
Note that you will need to select _Install a new iTop_ on the second page.

### Link with MySQL or MariaDB container

This methods works with both [MySQL](https://hub.docker.com/_/mysql/) or [MariaDB](https://hub.docker.com/_/mariadb/) containers.
For example, create this MariaDB instance named **my-itop-db**:

```shell
docker run -d --name=my-itop-db -e MYSQL_DATABASE=itop -e MYSQL_USER=itop -e MYSQL_PASSWORD=itop -e MYSQL_RANDOM_ROOT_PASSWORD=yes mariadb
```

The link needs to be called **db** in order to gain profit of it:

```shell
docker run -d -p 80:80 --link=my-itop-db:db --name=my-itop supervisions/itop:latest
```

### Scheduling cron.php

In order to operate properly, iTop maintenance operations and asynchronous tasks must be executed on a regular basis.
In order to ease the installation, all the background tasks have been grouped to be launched from a single file.
The command to run this from your sheduler looks like this:

```shell
docker exec my-itop php webservices/cron.php --auth_user=<login> --auth_pwd=<password>
```

If you don't want these credentials to be present in your sheduler, you can create a file `/etc/itop/cron.params` based on the file `webservices/cron.distrb` which can be used as a template.
The command to run from your sheduler then becomes this:

```shell
docker exec my-itop php webservices/cron.php --param_file=/etc/itop/cron.params
```

## Tags

* `3.2.1`, `3.2`, `latest`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_2_0:release:change_log#section3211)
* `3.1.3`, `3.1`
[(Changelog)](https://www.itophub.io/wiki/page?id=3_1_0:release:change_log#section313)
* `2.7.12`, `2.7`
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
