DOCKER=docker

NAME=zephyr_downloader

.PHONY: all build download clean rmi

all: build download

download:
	$(DOCKER) run -t -v $(shell pwd):/artifacts $(NAME)

build:
	$(DOCKER) build --no-cache --tag $(NAME) .

clean:
	$(RM) *.tar.bz2

rmi:
	$(DOCKER) rmi $(NAME)
