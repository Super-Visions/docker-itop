version = 2.7.6

all: build push

build:
	docker build --pull -t supervisions/itop:latest -t supervisions/itop:2.7 -t supervisions/itop:$(version) .

push:
	docker push supervisions/itop
	docker push supervisions/itop:2.7
	docker push supervisions/itop:$(version)
