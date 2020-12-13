DOCKER=docker

NAME=zephyr_downloader

.PHONY: all build

all:
	$(DOCKER) run -v $(shell pwd):/artifacts $(NAME)

build:
	$(DOCKER) build --tag $(NAME) .
