REGISTRY_PATH ?= ${DOCKER_REGISTRY_PATH}

.DEFAULT_GOAL := help

ifndef REGISTRY_PATH
$(error REGISTRY_PATH is not set)
endif

.PHONY: build
## build: build image
build:
	docker build -t ${REGISTRY_PATH}/helm .

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
