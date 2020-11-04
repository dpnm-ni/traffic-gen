IMAGES ?= tg-nginx tg-srs-bench tg-mqtt-stresser tg-emqtt-bench tg-callgen tg-wrk2 tg-iperf3
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
