version = 3.0.0-beta5

all: build push

build:
	docker build --pull -t supervisions/itop:latest -t supervisions/itop:3.0 -t supervisions/itop:$(version) .

push:
	docker push supervisions/itop
	docker push supervisions/itop:3.0
	docker push supervisions/itop:$(version)
