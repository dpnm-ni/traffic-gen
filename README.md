# traffic-gen
Generate various type of traffic (bulk, VOD, live streaming, IoT, etc.)

## Run
Firstly, user should have a `client` and a `server` with docker installed. To install docker:
```bash
sh -c "$(wget -O- https://get.docker.com)"
```
### Web traffic

```bash
# Web Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# wrk client to send request to web server
docker run -it --init --rm --network=host --name=tg-wrk2 dpnm/tg-wrk2 -c <NUM_CONNECTIONS> -R <REQUEST_PER_SEC> -d <DURATION> http://<SERVER_IP>:8080
```

### VoD traffic

```bash
# VoD Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# Client to watch VoD video
docker run -it --init --rm --network=host --name=tg-srs-bench dpnm/tg-srs-bench ./rtmp_play.sh -c <NUM_CONNECTIONS> -r rtmp://<SERVER_IP>/vod/bbb.mp4
```
### Live streaming traffic
```bash
# Live streaming Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# Client to live stream video to the Server. {i} will automatically be set from 0 to <NUM_CONNECTIONS>
docker run -it --init --rm --network=host --name=tg-srs-bench dpnm/tg-srs-bench ./rtmp_publish.sh -c <NUM_CONNECTIONS> -r rtmp://<SERVER_IP>/live/test_{i}
```
### IoT traffic
```bash
# MQTT Server
docker run -it --init --rm --network=host --name=tg-mosquitto eclipse-mosquitto

# Client to send data to MQTT server
docker run -it --init --rm --network=host --name=tg-emqtt-bench dpnm/tg-emqtt-bench pub -I 0.1 -t bench/%c -c <NUM_CONNECTIONS> tcp://<SERVER_IP>:1883
```

## Note and references
- Bulk traffic: iperf to iperf
- VoD and Live Streaming traffic: srs-bench to nginx+rtmp module ([guide](https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/)), nginx [rtmp module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) and [srs-bench](https://github.com/ossrs/srs-bench) as client ([guide](https://hardelm.github.io/2017/07/11/srs-bench%E5%AE%89%E8%A3%85%E4%B8%8E%E4%BD%BF%E7%94%A8))
- IoT data: [emqtt-bench](https://github.com/emqx/emqtt-bench) or [mqtt-stresser](https://github.com/inovex/mqtt-stresser) to [mosquitto](https://github.com/eclipse/mosquitto)
- VoIP traffic: Use iperf with [guide](http://wiki.innovaphone.com/index.php?title=Howto:Network_VoIP_Readiness_Test)


