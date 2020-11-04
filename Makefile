IMAGES ?= tg-nginx tg-srs-bench tg-mqtt-stresser tg-emqtt-bench tg-callgen
REPO ?= dpnm

build:
	for IMAGE in $(IMAGES); do \
		docker build -t $(REPO)/$$IMAGE docker/$$IMAGE; \
	done

force-build:
	for IMAGE in $(IMAGES); do \
		docker build -t $(REPO)/$$IMAGE --no-cache docker/$$IMAGE; \
	done

push:
	for IMAGE in $(IMAGES); do \
		docker push $(REPO)/$$IMAGE:latest; \
	done

.DEFAULT_GOAL=build
