version = 2.7.6
release = $(version)
patch = 8526

all: build push

build:
	docker build --pull \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t supervisions/itop \
		-t supervisions/itop:2.7 \
		-t supervisions/itop:$(version) \
		-t supervisions/itop:$(release) .

push:
	docker push supervisions/itop
	docker push supervisions/itop:2.7
	docker push supervisions/itop:$(version)
