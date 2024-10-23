version = 2.7.11
release = $(version)
patch = 14870
builder = itop_builder
platforms = linux/arm64,linux/amd64

all: setup_builder load

setup_builder:
	docker buildx inspect $(builder) > /dev/null || docker buildx create --name $(builder) --driver docker-container --platform $(platforms) --bootstrap

build: setup_builder
	# Build all supported platforms
	docker buildx build --pull \
		--builder $(builder) \
		--platform $(platforms) \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) .

load: setup_builder
	# Build and load current platform
	docker buildx build --pull --load \
		--builder $(builder) \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t supervisions/itop:2.7 \
		-t supervisions/itop:$(version) \
		-t supervisions/itop:$(release) .

push: setup_builder
	# Build and push all supported platforms
	docker buildx build --pull --push \
		--builder $(builder) \
		--platform $(platforms) \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t supervisions/itop:2.7 \
		-t supervisions/itop:$(version) .
