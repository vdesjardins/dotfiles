REGISTRY_PATH ?= ${DOCKER_REGISTRY_PATH}

HELM_VERSION ?= v3.1.2
GCS_PLUGIN_VERSION ?= 0.3.1
DIFF_PLUGIN_VERSION ?= v3.1.1

.DEFAULT_GOAL := help

ifndef REGISTRY_PATH
$(error REGISTRY_PATH is not set)
endif

.PHONY: build
## build: build image
build:
	docker build \
		--pull \
		--build-arg HELM_VERSION=${HELM_VERSION} \
		--build-arg GCS_PLUGIN_VERSION=${GCS_PLUGIN_VERSION} \
		--build-arg DIFF_PLUGIN_VERSION=${DIFF_PLUGIN_VERSION} \
		-t ${REGISTRY_PATH}/helm .

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
