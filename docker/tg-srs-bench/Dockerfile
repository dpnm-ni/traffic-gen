FROM jrottenberg/ffmpeg:4.1-ubuntu AS builder
RUN apt-get update && \
	apt-get install -y wget

RUN mkdir /mp4s && \
    wget -q http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4 -O /bbb.mp4
RUN ffmpeg -i /bbb.mp4 -c:v libx264 -crf 19 /bbb.flv


FROM debian:stretch-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y git make unzip g++ && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/simple-rtmp-server/srs-bench.git
RUN cd /srs-bench && \
    ./configure && \
    make

RUN echo 'alias rtmp_play="./srs-bench/objs/sb_rtmp_load_fast"' >> ~/.bashrc
RUN echo 'alias rtmp_publish="./srs-bench/objs/sb_rtmp_publish -i /mp4s/bbb.mp4"' >> ~/.bashrc

RUN mkdir /videos
COPY --from=builder /bbb.flv /videos/

ADD rootfs/ /
RUN chmod a+x /rtmp_play.sh
RUN chmod a+x /rtmp_publish.sh
