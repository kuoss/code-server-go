IMAGE=ghcr.io/kuoss/code-server-go:4.16.1-go1.20.8

build:
	docker build -t $(IMAGE) . &&	docker push $(IMAGE)
