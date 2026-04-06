PODMAN   ?= podman
REGISTRY ?= registry.lab.tk-sputnik.org
IMAGE    ?= sputnik
TAG      ?= latest

FULL_IMAGE = $(REGISTRY)/$(IMAGE):$(TAG)

.PHONY: build push build-push login frontend

frontend:
	cd frontend && npm install && npm run build

build:
	$(PODMAN) build -f Dockerfile.prod -t $(FULL_IMAGE) --platform linux/amd64 .

push:
	$(PODMAN) push $(FULL_IMAGE)

build-push: build push

frontend-build-push: frontend build push

login:
	$(PODMAN) login $(REGISTRY)
