.DEFAULT_GOAL := help

.PHONY: all
## all: build all images
all: helm terraform

.PHONY: helm
## helm: build image
helm:
	${MAKE} -C ./helm build

.PHONY: terraform
## terraform: build image
terraform:
	${MAKE} -C ./terraform build

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
