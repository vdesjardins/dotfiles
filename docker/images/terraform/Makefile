REGISTRY_PATH ?= ${DOCKER_REGISTRY_PATH}

TF_VERSION ?= 0.12.23

.DEFAULT_GOAL := help

SHELL := /bin/bash

ifndef REGISTRY_PATH
$(error REGISTRY_PATH is not set)
endif

.PHONY: build
## build: build image
build: sha256sum
	@if [[ -d ~/.config/my-cacerts/ ]]; then \
		cp ~/.config/my-cacerts/* certs/; \
	fi

	@docker build \
		--build-arg TF_VERSION=${TF_VERSION} \
		--build-arg TF_SHA256SUM=${TF_SHA256SUM} \
		-t ${REGISTRY_PATH}/terraform-helm .

.PHONY: sha256sum
sha256sum:
	$(eval TF_SHA256SUM = $(shell curl -s https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip | shasum -a 256 - | awk '{print $$1;}'))

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
