version = 3.0.0
release = $(version)-beta5
patch = 8216

all: build push

build:
	docker build --pull \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t supervisions/itop \
		-t supervisions/itop:3.0 \
		-t supervisions/itop:$(version) \
		-t supervisions/itop:$(release) .

push:
	docker push supervisions/itop
	docker push supervisions/itop:3.0
	docker push supervisions/itop:$(version)
