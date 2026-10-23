version = 3.3.0
release = $(version)
patch = 21411
checksum = b4e52f8d5da53d990630a11dbda943de110cb9df6fea8228e382443975abc0e4
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
		--build-arg patch=$(patch) \
		--build-arg checksum=$(checksum) .

load: setup_builder
	# Build and load current platform
	docker buildx build --pull --load \
		--builder $(builder) \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		--build-arg checksum=$(checksum) \
		-t supervisions/itop \
		-t supervisions/itop:3.3 \
		-t supervisions/itop:$(version) \
		-t supervisions/itop:$(release) .

push: setup_builder
	# Build and push all supported platforms
	docker buildx build --pull --push \
		--provenance=mode=max \
		--builder $(builder) \
		--platform $(platforms) \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		--build-arg checksum=$(checksum) \
		-t supervisions/itop \
		-t supervisions/itop:3.3 \
		-t supervisions/itop:$(version) .
