# iTop

Run [iTop](https://www.combodo.com/itop-193) in Docker image based on [php:apache](https://hub.docker.com/_/php/).

[![](https://images.microbadger.com/badges/image/supervisions/itop.svg)](https://microbadger.com/images/supervisions/itop "Get your own image badge on microbadger.com")

## Usage

Run the latest version (see tags for other iTop versions) container named *my-itop*:
```
docker run -d -p 80:80 --name=my-itop supervisions/itop:latest
```
Then go to [http://localhost/](http://localhost/) to continue the installation.
