
IMAGE_NAME := "openvpn_exporter"
IMAGE_TAG := $(shell git describe --always --tags)

static: deps
	CGO_ENABLED=0 go build -ldflags '-s' openvpn_exporter.go

deps:
	go get -v

docker: static
	docker build -t "$(IMAGE_NAME):$(IMAGE_TAG)" .
	docker tag "$(IMAGE_NAME):$(IMAGE_TAG)" "$(IMAGE_NAME):latest"

docker-push: docker
	docker push "$(IMAGE_NAME):$(IMAGE_TAG)"
