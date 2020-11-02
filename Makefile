IMAGES ?= tg-nginx tg-srs-bench tg-mqtt-stresser tg-emqtt-bench
REPO ?= dpnm

build:
	for IMAGE in $(IMAGES); do \
		docker build -t $(REPO)/$$IMAGE docker/$$IMAGE; \
	done

.DEFAULT_GOAL=build
