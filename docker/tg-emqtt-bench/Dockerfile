FROM erlang:22.1-slim as builder
RUN apt-get update && \
    apt-get install -y git make && \
    apt-get clean
RUN git clone --depth=1 https://github.com/emqx/emqtt-bench && \
    cd /emqtt-bench && \
    make

FROM erlang:22.1-slim
COPY --from=builder /emqtt-bench/emqtt_bench /
ENTRYPOINT ["/emqtt_bench"]
