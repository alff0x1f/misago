CONTAINER_ENGINE ?= podman

REGISTRY ?= registry.lab.tk-sputnik.org
IMAGE_NAME ?= sputnik
TAG ?= latest
IMAGE := $(if $(REGISTRY),$(REGISTRY)/,)$(IMAGE_NAME):$(TAG)

PROD_DOCKERFILE ?= Dockerfile.prod

.PHONY: help prod-build prod-push

help:
	@echo "Common targets:"
	@echo "  make prod-build CONTAINER_ENGINE=docker REGISTRY=my.registry IMAGE_NAME=misago TAG=1.0.0"
	@echo "      Build production image using Dockerfile.prod."
	@echo "  make prod-push CONTAINER_ENGINE=docker REGISTRY=my.registry IMAGE_NAME=misago TAG=1.0.0"
	@echo "      Push the previously built image to your registry."

prod-build:
	@echo "Building image $(IMAGE) using $(PROD_DOCKERFILE) with $(CONTAINER_ENGINE)"
	$(CONTAINER_ENGINE) build -f $(PROD_DOCKERFILE) -t $(IMAGE) .

prod-push:
	@echo "Pushing image $(IMAGE) with $(CONTAINER_ENGINE)"
	$(CONTAINER_ENGINE) push $(IMAGE)
