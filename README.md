iTop
====

Run [iTop](https://www.itophub.io) in a Docker container based on the [php:apache](https://hub.docker.com/_/php/) image.

[![iTop layer size](https://images.microbadger.com/badges/image/supervisions/itop.svg)](https://microbadger.com/images/supervisions/itop "Get your own image badge on microbadger.com")

## Usage

Run the latest version (see tags for other iTop versions) container named **my-itop**:

```
docker run -d -p 80:80 --name=my-itop supervisions/itop:latest
```
Then go to [http://localhost/setup](http://localhost/setup) to continue the installation.
The setup can be preloaded with database credentials by linking to a MySQL/MariaDB container or by providing environment variables.
Note that you will need to select _Install a new iTop_ on the second page.

### Link with MySQL or MariaDB container

This methods works with both [MySQL](https://hub.docker.com/_/mysql/) or [MariaDB](https://hub.docker.com/_/mariadb/) containers.
For example, create this MariaDB instance named **my-itop-db**:

```
docker run -d --name=my-itop-db -e MYSQL_DATABASE=itop -e MYSQL_USER=itop -e MYSQL_PASSWORD=itop -e MYSQL_RANDOM_ROOT_PASSWORD=yes mariadb
```
The link needs to be called **db** in order to gain profit of it:

```
docker run -d -p 80:80 --link=my-itop-db:db --name=my-itop supervisions/itop:latest
```

### Scheduling cron.php

In order to operate properly, iTop maintenance operations and asynchronous tasks must be executed on a regular basis.
In order to ease the installation, all the background tasks have been grouped to be launched from a single file.
The command to run this from your sheduler looks like this:

```
docker exec my-itop php webservices/cron.php --auth_user=<login> --auth_pwd=<password>
```
If you don't want these credentials to be present in your sheduler, you can create a file `/etc/itop/cron.params` based on the file `webservices/cron.distrb` which can be used as a template.
The command to run from your sheduler then becomes this:

```
docker exec my-itop php webservices/cron.php --param_file=/etc/itop/cron.params
```

## Tags

* `2.7.4`, `2.7`, `latest` [(Readme)](https://github.com/Combodo/iTop/blob/2.7.4/README.md)
* `2.7.3` [(Readme)](https://github.com/Combodo/iTop/blob/2.7.3/README.md)
* `2.7.2` [(Readme)](https://github.com/Combodo/iTop/blob/2.7.2-1/README.md)
* `2.7.1` [(Readme)](https://github.com/Combodo/iTop/blob/2.7.1/README.md)
* `2.7.0` [(Readme)](https://github.com/Combodo/iTop/blob/2.7.0-2/README.md)
* `2.6.3`, `2.6` [(Readme)](https://github.com/Combodo/iTop/blob/2.6.3/README.md)
* `2.6.1`, [(Readme)](https://github.com/Combodo/iTop/blob/2.6.1/README.md)
* `2.6.0` [(Readme)](https://github.com/Combodo/iTop/blob/2.6.0/README.md)
* `2.5.1`, `2.5` [(Readme)](https://github.com/Combodo/iTop/blob/2.5.1/readme.txt)
* `2.5.0` [(Readme)](https://github.com/Combodo/iTop/blob/2.5.0/readme.txt)
* `2.4.3`, `2.4` [(Readme)](https://github.com/Combodo/iTop/blob/2.4.3/readme.txt)
* `2.4.1` [(Readme)](https://github.com/Combodo/iTop/blob/2.4.1/readme.txt)
* `2.4.0` [(Readme)](https://github.com/Combodo/iTop/blob/2.4.0/readme.txt)
* `2.3.4`, `2.3` [(Readme)](https://github.com/Combodo/iTop/blob/2.3.4/readme.txt)
* `2.3.3` [(Readme)](https://github.com/Combodo/iTop/blob/2.3.3/readme.txt)
