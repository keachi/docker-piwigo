.DEFAULT_GOAL := help

IMAGE_NAME			:= keachi/piwigo
SHELL				:= /bin/bash

SCMD := $(shell \
	if ! id -n -G | grep -q docker; then \
		echo sudo; \
	fi \
)

NCPU := $(shell \
	getconf _NPROCESSORS_ONLN 2>/dev/null || \
	getconf NPROCESSORS_ONLN 2>/dev/null || echo 1 \
)
MEM := $(shell \
	echo $$(free -m | awk '/^Mem/ {print int($$7 * 0.8)}')M \
)

export NCPU
export MEM

DOCKER_ENV := -e "NCPU=$(NCPU)"						\
	-e "TERM=$(TERM)"								\
	-v "$(PWD)":"$(HOSTDIR)"

all:

help:  ## display this help
	@cat $(MAKEFILE_LIST) | grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' | \
		sort -k1,1 | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: .build  ## build docker image

.build:
	$(SCMD) docker build -t $(IMAGE_NAME) .

root-shell: | build  ## open a root-shell in container
	@$(SCMD) docker run $(DOCKER_ENV) \
		-it $(IMAGE_NAME) $(SHELL); true

shell: | build  ## open a shell in a container
	@$(SCMD) docker run $(DOCKER_ENV) \
		-u $(shell id -u) \
		-it $(IMAGE_NAME) $(SHELL); true

clean: cleanup  ## remove actual docker image
	@$(SCMD) docker rmi $(IMAGE_NAME)

cleanup:  ## generic docker cleanup
	$(SCMD) docker ps -q -f status=exited | xargs -r $(SCMD) docker rm -v
	$(SCMD) docker images -q -f dangling=true | xargs -r $(SCMD) docker rmi
	$(SCMD) docker volume ls -q -f dangling=true | xargs -r $(SCMD) docker volume rm


.PHONY: all help build .build root-shell shell clean cleanup

# vim: set noexpandtab ts=4 sw=4 ft=make :
