version = 3.0.2
release = $(version)-1
patch = 9956

all: build package

build:
	docker build --pull \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t itop-essential:latest \
		-t itop-essential:$(version) .

package:
	docker save itop-essential | gzip > files/iTop-essential-docker.tar.gz

load:
	gunzip -c files/iTop-essential-docker.tar.gz | docker load
