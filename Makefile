DOCKER_EXE = docker

NAME_ZEPHYR = zephyr_downloader_zephyr
NAME_1804 = zephyr_downloader_1804
NAME_2004 = zephyr_downloader_2004

.PHONY: all build download clean rmi

all: build download

download:
	rm -fr output
	mkdir -p output
	$(DOCKER_EXE) run -t -v $(shell pwd)/output:/artifacts $(NAME_ZEPHYR)
	$(DOCKER_EXE) run -t -v $(shell pwd)/output:/artifacts $(NAME_1804)
	$(DOCKER_EXE) run -t -v $(shell pwd)/output:/artifacts $(NAME_2004)

build:
	$(DOCKER_EXE) build -f Dockerfile.zephyr --no-cache --tag $(NAME_ZEPHYR) .
	$(DOCKER_EXE) build -f Dockerfile.pip_1804 --no-cache --tag $(NAME_1804) .
	$(DOCKER_EXE) build -f Dockerfile.pip_2004 --no-cache --tag $(NAME_2004) .

clean:
	$(RM) output/*.tar.bz2

rmi:
	$(DOCKER_EXE) rmi $(NAME_ZEPHYR)
	$(DOCKER_EXE) rmi $(NAME_1804)
	$(DOCKER_EXE) rmi $(NAME_2004)
