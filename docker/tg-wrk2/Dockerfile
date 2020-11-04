FROM debian:stretch-slim AS builder

# Install dependencies
RUN apt-get update && \
    apt-get install -y git make gcc openssl libssl-dev libz-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/giltene/wrk2.git
RUN cd /wrk2 && \
    make


FROM debian:stretch-slim
RUN apt-get update && \
    apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /wrk2/wrk /wrk

ENTRYPOINT ["/wrk", "-c", "100"]
