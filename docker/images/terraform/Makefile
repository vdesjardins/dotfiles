REGISTRY_PATH ?= ${DOCKER_REGISTRY_PATH}

TF_VERSION ?= 0.12.20

.DEFAULT_GOAL := help

.PHONY: build
## build: build image
build:
	docker build -t ${REGISTRY_PATH}/terraform-helm .

.PHONY: sha256sum
## sha256sum: Calculate SHA 256 sum
sha256sum:
	curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip | shasum -a 256 -

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
