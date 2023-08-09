version = 3.1.0
release = $(version)-2
patch = 11970

all: build package

build:
	docker build --pull \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t itop-professional:latest \
		-t itop-professional:$(version) .

package:
	docker save itop-professional | gzip > files/iTop-professional-docker.tar.gz

load:
	gunzip -c files/iTop-professional-docker.tar.gz | docker load
