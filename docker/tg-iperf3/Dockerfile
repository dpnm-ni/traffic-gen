FROM debian:stretch-slim

RUN apt-get update && \
    apt-get install -y wget libsctp1 && \
    wget https://iperf.fr/download/ubuntu/libiperf0_3.7-3_amd64.deb && \
    wget https://iperf.fr/download/ubuntu/iperf3_3.7-3_amd64.deb && \
    apt-get install -y ./libiperf0_3.7-3_amd64.deb ./iperf3_3.7-3_amd64.deb && \
    rm libiperf0_3.7-3_amd64.deb iperf3_3.7-3_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["iperf3"]
