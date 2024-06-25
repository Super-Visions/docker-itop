version = 3.1.4
release = $(version)
patch = 2312
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
		-t supervisions/teemip \
		-t supervisions/teemip:3.1 \
		-t supervisions/teemip:$(version) \
		-t supervisions/teemip:$(release) .

push: setup_builder
	# Build and push all supported platforms
	docker buildx build --pull --push \
		--builder $(builder) \
		--platform $(platforms) \
		--build-arg release=$(release) \
		--build-arg patch=$(patch) \
		-t supervisions/teemip \
		-t supervisions/teemip:3.1 \
		-t supervisions/teemip:$(version) .
