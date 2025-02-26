# docker-smokeping-speedtest
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/arthurlockman/docker-smokeping-speedtest/Master?label=build%20%28master%29)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/arthurlockman/docker-smokeping-speedtest/Daily?label=build%20%28nightly%29)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/arthurlockman/smokeping-speedtest/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/jwigley/smokeping-speedtest.svg)](https://hub.docker.com/r/arthurlockman/smokeping-speedtest/)

Smokeping docker image with [smokeping-speedtest](https://github.com/mad-ady/smokeping-speedtest) probe and Ookla's official speedtest CLI, built upon linuxserver's [docker-smokeping](https://github.com/linuxserver/docker-smokeping) image.

## docker repository

[arthurlockman/smokeping-speedtest](https://hub.docker.com/repository/docker/arthurlockman/smokeping-speedtest)

## usage

```bash
docker run \
  -d \
  --name=smokeping-speedtest \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v /path/to/smokeping/config:/config \
  -v /path/to/smokeping/data:/data \
  --restart unless-stopped \
  arthurlockman/smokeping-speedtest
```

The default speedtest configuration will poll downloads/uploads every hour to your closest speedtest.net server.
Results are displayed under the 'Speed Tests' menu in Smokeping.
This can be modified by via the Probes and Targets config files as per the instructions at https://github.com/mad-ady/smokeping-speedtest.

## credits

This docker image just pieces the bits together. The real work is all done by:
  - [mad-ady](https://github.com/mad-ady)'s [smokeping-speedtest](https://github.com/mad-ady/smokeping-speedtest)
  - [sivel](https://github.com/sivel)'s [speedtest-cli](https://github.com/sivel/speedtest-cli)
  - [linuxserver](https://github.com/linuxserver)'s [docker-smokeping](https://github.com/linuxserver/docker-smokeping)
