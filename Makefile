.DEFAULT_GOAL=help

# Required for globs to work correctly
SHELL := /bin/bash
VERSION := $(shell git describe --tags --always)

.EXPORT_ALL_VARIABLES:

.PHONY: all
all: build  ## build all default targets

.PHONY: build
build: build-base build-model  ## build all images

.PHONY: build-base
build-base:  ## build base image
	docker build . \
		-f Dockerfile.base \
		-t hangxie/ray-vllm-base:$(VERSION)

.PHONY: build-model
build-model:  ## build model image
	docker build . \
		--secret id=HF_TOKEN,env=HF_TOKEN \
		-f Dockerfile.model \
		-t hangxie/ray-vllm:$(VERSION)-qwen

.PHONY: help
help:  ## Print list of Makefile targets
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		cut -d ":" -f1- | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
