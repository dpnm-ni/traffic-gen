# traffic-gen
Generate various type of traffic (bulk, VOD, live streaming, IoT, etc.)

## Run
Firstly, user should have a `client` and a `server` with docker installed. To install docker:
```bash
sh -c "$(wget -O- https://get.docker.com)"
```
### Web traffic
[wrk2](https://github.com/giltene/wrk2) as the web client and nginx as web server
```bash
# Web Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# wrk client to send request to web server
docker run -it --init --rm --network=host --name=tg-wrk2 dpnm/tg-wrk2 -c <NUM_CONNECTIONS> -R <REQUEST_PER_SEC> -d <DURATION> http://<SERVER_IP>:8080
# for help, check wrk2 repo or run:
docker run dpnm/tg-wrk2 --help
```

### VoD traffic
[srs-bench](https://github.com/ossrs/srs-bench) as client and nginx [rtmp module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) as the VoD server.
```bash
# VoD Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# Client to watch VoD video
docker run -it --init --rm --network=host --name=tg-srs-bench dpnm/tg-srs-bench ./rtmp_play.sh -c <NUM_CONNECTIONS> -r rtmp://<SERVER_IP>/vod/bbb.mp4
# for help, check srs-bench repo or run:
docker run dpnm/tg-srs-bench ./rtmp_play.sh --help
```
### Live streaming traffic
srs-bench as client and nginx rtmp module as the live streaming server.
```bash
# Live streaming Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# Client to live stream video to the Server. {i} will automatically be set from 0 to <NUM_CONNECTIONS>
docker run -it --init --rm --network=host --name=tg-srs-bench dpnm/tg-srs-bench ./rtmp_publish.sh -c <NUM_CONNECTIONS> -r rtmp://<SERVER_IP>/live/test_{i}
# for help, check srs-bench repo or run:
docker run dpnm/tg-srs-bench ./rtmp_publish.sh --help
```
### IoT traffic
[emqtt-bench](https://github.com/emqx/emqtt-bench) as the client to publish MQTT messages to [mosquitto](https://github.com/eclipse/mosquitto)
```bash
# MQTT Server
docker run -it --init --rm --network=host --name=tg-mosquitto eclipse-mosquitto

# Client to send data to MQTT server
docker run -it --init --rm --network=host --name=tg-emqtt-bench dpnm/tg-emqtt-bench pub -I 0.1 -t bench/%c -c <NUM_CONNECTIONS> tcp://<SERVER_IP>:1883
# for help, check emqtt-bench repo or run:
docker run dpnm/tg-emqtt-bench pub --help
```

## References
- VoD and Live Streaming traffic [setup guide](https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/) and [srs-bench guide](https://hardelm.github.io/2017/07/11/srs-bench%E5%AE%89%E8%A3%85%E4%B8%8E%E4%BD%BF%E7%94%A8)



