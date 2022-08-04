version = 2.7.7
release = $(version)
patch = 9622

all: build push

build:
	docker build --pull \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t supervisions/itop:2.7 \
		-t supervisions/itop:$(version) \
		-t supervisions/itop:$(release) .

push:
	docker push supervisions/itop:2.7
	docker push supervisions/itop:$(version)
