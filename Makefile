
IMAGE_NAME := "openvpn_exporter"
IMAGE_TAG := $(shell git describe --always --tags)

static: deps
	CGO_ENABLED=0 go build -ldflags '-s' openvpn_exporter.go

deps:
	go get -v

build-in-docker:
	docker run --rm \
		-v $(PWD):/go/src/app \
		-w /go/src/app \
		golang:1.8 \
		make static

docker:
	docker build -t "$(IMAGE_NAME):$(IMAGE_TAG)" .
	docker tag "$(IMAGE_NAME):$(IMAGE_TAG)" "$(IMAGE_NAME):latest"

docker-push: docker
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"
