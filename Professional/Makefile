all: build package

build:
	docker build --pull -t itop-professional:latest -t itop-professional:2.7.6 .

package:
	docker save itop-professional | gzip > files/iTop-professional-docker.tar.gz

load:
	gunzip -c files/iTop-professional-docker.tar.gz | docker load
