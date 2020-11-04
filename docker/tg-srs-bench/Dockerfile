FROM jrottenberg/ffmpeg:4.1-ubuntu AS builder
RUN apt-get update && \
	apt-get install -y wget

RUN mkdir /mp4s && \
    wget -q http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4 -O /bbb.mp4
RUN ffmpeg -i /bbb.mp4 -c:v libx264 -crf 19 /bbb.flv


FROM debian:stretch-slim AS compiler

# Install dependencies
RUN apt-get update && \
    apt-get install -y git make unzip g++ && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/simple-rtmp-server/srs-bench.git
RUN cd /srs-bench && \
    ./configure && \
    make


FROM debian:stretch-slim

RUN mkdir /videos
RUN mkdir -p /srs-bench/objs
COPY --from=builder /bbb.flv /videos/
COPY --from=compiler /srs-bench/objs /srs-bench/objs

ADD rootfs/ /
RUN chmod a+x /rtmp_play.sh
RUN chmod a+x /rtmp_publish.sh
