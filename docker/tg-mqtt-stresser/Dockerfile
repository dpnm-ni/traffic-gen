FROM golang:1.12 as builder

RUN apt-get update && \
    apt-get install -y make git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/inovex/mqtt-stresser /go/src/github.com/inovex/mqtt-stresser
WORKDIR /go/src/github.com/inovex/mqtt-stresser
RUN make linux-static-amd64

FROM debian:stretch-slim

ARG BUILD_DATE="1985-04-12T23:20:50.52Z"
ARG VCS_REF=not-specified
ARG VERSION=not-specified
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="mqtt-stresser"
LABEL org.label-schema.vcs-url="https://github.com/inovex/mqtt-stresser"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$VERSION

COPY --from=builder /go/src/github.com/inovex/mqtt-stresser/build/mqtt-stresser-linux-amd64-static /bin/mqtt-stresser
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY /rootfs/ /

RUN chmod a+x /mqtt-stresser.sh

ENTRYPOINT [ "/mqtt-stresser.sh" ]
