# traffic-gen
Traffic-gen can be used to deploy various services (VOD, live streaming, IoT, web, video call, etc) and generate traffic to that services.

### Run
Firstly, user should have a `client` and a `server` with docker installed. To install docker:
```bash
sh -c "$(wget -O- https://get.docker.com)"
```
User does not need to clone this repo, just run the bellow command(s) depend on the type of traffic needed. If user only need to deploy service without generating traffic, just run the command on server side only.

### Web traffic
[wrk2](https://github.com/giltene/wrk2) as the web client and nginx as web server. Webserver serves basic nginx welcome page.
```bash
# Web Server
docker run -it --init --rm --network=host --name=tg-nginx dpnm/tg-nginx

# wrk client to send request to web server
docker run -it --init --rm --network=host --name=tg-wrk2 dpnm/tg-wrk2 -c <NUM_CONNECTIONS> -R <REQUEST_PER_SEC> -d <DURATION> http://<SERVER_IP>:8080
# for help, check wrk2 repo or run:
docker run dpnm/tg-wrk2 --help
```

### VoD traffic
[srs-bench](https://github.com/ossrs/srs-bench) as client and nginx [rtmp module](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) as the VoD server. VoD server serves BigBugBunny video at endpoint `/vod/bbb.mp4`.
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
### VoIP/Video call traffic
iperf3 can be used to emulate VoIP/Video call traffic ([guide](http://wiki.innovaphone.com/index.php?title=Howto:Network_VoIP_Readiness_Test)). Bandwidth is set to 2 Mbps to emulate HD video call. Packet size is set to 1200 as [ref](https://stackoverflow.com/questions/47635545/why-webrtc-chose-rtp-max-packet-size-to-1200-bytes#:~:text=By%20studying%20WebRTC%20sources%20I,.cc%2C%20as%20kVideoMtu%20variable)
```bash
# Server
docker run -it --init --rm --network=host --name=tg-iperf3-server dpnm/tg-iperf3 -s

# Client to emulate "call" to server
docker run -it --init --rm --network=host --name=tg-iperf3-client dpnm/tg-iperf3 -c <SERVER_IP> -u --bidir -S 184 -l 1200 -b 2M -t <DURATION> -P <NUM_CONNECTIONS>
# for help, check iperf repo or run:
docker run dpnm/tg-iperf --help
```
### Bulk traffic
iperf3 can be used to emulate large volume of generic TCP/UDP traffic
```bash
# Server
docker run -it --init --rm --network=host --name=tg-iperf3-server dpnm/tg-iperf3 -s

# Client
docker run -it --init --rm --network=host --name=tg-iperf3-client dpnm/tg-iperf3 -c <SERVER_IP> -t <DURATION>
# for help, check iperf repo or run:
docker run dpnm/tg-iperf --help
```
## References
- VoD and Live Streaming traffic [setup guide](https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/) and [srs-bench guide](https://hardelm.github.io/2017/07/11/srs-bench%E5%AE%89%E8%A3%85%E4%B8%8E%E4%BD%BF%E7%94%A8)
