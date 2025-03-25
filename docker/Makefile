TOP ?= $(shell git rev-parse --show-toplevel)

# Settings for docker image
DOCKER_PLATFORM ?= ubuntu24.04
#DOCKER_PLATFORM ?= centos7
DOCKER_WORKDIR ?= /work
USE_LOCAL_CREDENTIALS ?=

docker-image: ## creates a docker image
	@$(eval USER_NAME    := $(if $(USE_LOCAL_CREDENTIALS),$(USER),build))
	@$(eval USER_ID      := $(if $(USE_LOCAL_CREDENTIALS),$(shell id -u),1234))
	@$(eval GROUP_NAME   := $(if $(USE_LOCAL_CREDENTIALS),$(USER)))
	@$(eval GROUP_ID     := $(if $(USE_LOCAL_CREDENTIALS),$(shell id -g),5678))
	@$(eval OTHER_GROUPS := $(if $(USE_LOCAL_CREDENTIALS),$(shell id --groups),))
	@$(DOCKER) build . -f Dockerfile.$(DOCKER_PLATFORM) \
		--build-arg USER_NAME="$(USER_NAME)" \
		--build-arg USER_ID="$(USER_ID)" \
		--build-arg GROUP_NAME="$(GROUP_NAME)" \
		--build-arg GROUP_ID="$(GROUP_ID)" \
		--build-arg OTHER_GROUPS="$(OTHER_GROUPS)" \
		--build-arg WORKDIR=$(DOCKER_WORKDIR) \
		-t $(CONTAINER_NAME)

docker-run: docker-image
docker-run: ## mounts as a docker container
	@$(eval CONTAINER_NAME := $(notdir $(TOP)))
	@$(DOCKER) run \
		--volume=$(TOP):$(DOCKER_WORKDIR)/$(CONTAINER_NAME) \
		-it $(CONTAINER_NAME)

