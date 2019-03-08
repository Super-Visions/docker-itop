all: build package

build:
	docker build -t itop-essential:latest -t itop-essential:2.6.0 .

package:
	docker save itop-essential | gzip > files/iTop-essential-docker.tar.gz

load:
	gunzip -c files/iTop-essential-docker.tar.gz | docker load
