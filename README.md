[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/radarr](https://github.com/linuxserver/docker-radarr)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/radarr.svg)](https://microbadger.com/images/linuxserver/radarr "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/radarr.svg)](https://microbadger.com/images/linuxserver/radarr "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/radarr.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/radarr.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-radarr/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-radarr/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/radarr/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/radarr/latest/index.html)

[Radarr](https://github.com/Radarr/Radarr) - A fork of Sonarr to work with movies à la Couchpotato.


[![radarr](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/radarr.png)](https://github.com/Radarr/Radarr)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

Simply pulling `linuxserver/radarr` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=radarr \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 7878:7878 \
  -v <path to data>:/config \
  -v <path/to/movies>:/movies \
  -v <path/to/downloadclient-downloads>:/downloads \
  --restart unless-stopped \
  linuxserver/radarr
```

You can choose between ,using tags, various branch versions of radarr, no tag is required to remain on the main branch.

Add one of the tags,  if required,  to the linuxserver/radarr line of the run/create command in the following format, linuxserver/radarr:nightly

The nightly branch and master branch can from time to time be the same version.

HOWEVER , USE THE NIGHTLY BRANCH AT YOUR OWN PERIL !!!!!!!!!


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  radarr:
    image: linuxserver/radarr
    container_name: radarr
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
      - <path/to/movies>:/movies
      - <path/to/downloadclient-downloads>:/downloads
    ports:
      - 7878:7878
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 7878` | The port for the Radarr webinterface |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London, this is required for Radarr |
| `-v /config` | Database and Radarr configs |
| `-v /movies` | Location of Movie library on disk |
| `-v /downloads` | Location of download managers output directory |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

Access the webui at `<your-ip>:7878`, for more information check out [Radarr](https://github.com/Radarr/Radarr).



## Support Info

* Shell access whilst the container is running: `docker exec -it radarr /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f radarr`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' radarr`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/radarr`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/radarr`
* Stop the running container: `docker stop radarr`
* Delete the container: `docker rm radarr`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start radarr`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/radarr`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **09.09.18:** - Add pipeline build process.
* **24.02.18:** - Add nightly branch.
* **06.02.18:** - Radarr repo changed owner.
* **15.12.17:** - Fix continuation lines.
* **17.04.17:** - Switch to using inhouse mono baseimage, adds python also.
* **13.04.17:** - Switch to official mono repository.
* **10.01.17:** - Initial Release.
