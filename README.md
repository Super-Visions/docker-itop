# iTop

Run [iTop](https://www.combodo.com/itop-193) in Docker image based on [php:apache](https://hub.docker.com/_/php/).

[![](https://images.microbadger.com/badges/image/supervisions/itop.svg)](https://microbadger.com/images/supervisions/itop "Get your own image badge on microbadger.com")

## Usage

Run the latest version (see tags for other iTop versions) container named *my-itop*:
```
docker run -d -p 80:80 --name=my-itop supervisions/itop:latest
```
Then go to [http://localhost/](http://localhost/) to continue the installation.
The setup can be preloaded with database credentials by linking to a MySQL/MariaDB container or by providing environment variables.
Note that you will need to select _Install a new iTop_ on the second page.

### Link with MySQL or MariaDB container

This methods works with both [MySQL](https://hub.docker.com/_/mysql/) or [MariaDB](https://hub.docker.com/_/mariadb/) containers.
For example, create this MySQL instance named **my-itop-db**:

```
docker run -d --name=my-itop-db -e MYSQL_DATABASE=itop -e MYSQL_USER=itop -e MYSQL_PASSWORD=itop -e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:latest
```
The link needs to be called **db** in order to gain profit of it:

```
docker run -d -p 80:80 --link=my-itop-db:db --name=my-itop supervisions/itop:latest
```
