version = 3.1.1
release = $(version)-1
patch = 12564

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
