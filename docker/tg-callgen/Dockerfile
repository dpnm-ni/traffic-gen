FROM debian:stretch-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y git make g++ pkg-config flex bison && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /

ENV PTLIBDIR=/ptlib
ENV OPENH323DIR=/h323plus
ENV PWLIBPLUGINDIR=/usr/local/lib/pwlib

RUN git clone --depth 1 https://github.com/willamowius/ptlib.git $PTLIBDIR && \
    cd $PTLIBDIR && \
    ./configure --enable-ipv6 --disable-odbc --disable-sdl --disable-lua --disable-expat && \
    make optnoshared

RUN git clone --depth 1 https://github.com/willamowius/h323plus.git $OPENH323DIR && \
    cd $OPENH323DIR && \
    ./configure --enable-h235 -enable-h46017 --enable-h46019m && \
    make  optnoshared


RUN git clone --depth 1 https://github.com/willamowius/callgen323.git && \
    cd /callgen323 && \
    make optnoshared

RUN cp /callgen323/ogm.wav /ogm.wav

ENTRYPOINT ["./callgen323/obj_linux_x86_64_d_s/callgen323"]
