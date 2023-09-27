TAG=development
IMAGE=ghcr.io/kuoss/code-server-go:$(TAG)

build:
	docker build -t $(IMAGE) .

