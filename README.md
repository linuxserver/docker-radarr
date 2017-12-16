[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/Radarr/Radarr
[hub]: https://hub.docker.com/r/linuxserver/radarr/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/radarr
[![](https://images.microbadger.com/badges/version/linuxserver/radarr.svg)](https://microbadger.com/images/linuxserver/radarr "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/radarr.svg)](https://microbadger.com/images/linuxserver/radarr "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/radarr.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/radarr.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-radarr)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-radarr/)

[Radarr][appurl] - A fork of Sonarr to work with movies à la Couchpotato. 

[![radarr](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/radarr.png)][appurl]

## Usage

```
docker create \
  --name=radarr \
	-v <path to data>:/config \
	-v <path to data>:/downloads \
	-v <path to data>:/movies \
	-v /etc/localtime:/etc/localtime:ro \
	-e TZ=<timezone> \
	-e PGID=<gid> -e PUID=<uid>  \
	-p 7878:7878 \
  linuxserver/radarr
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 7878` - the port(s)
* `-v /config` - Radarr Application Data
* `-v /downloads` - Downloads Folder
* `-v /movies` - Movie Share
* `-v /etc/localtime` for timesync - see [Localtime](#localtime) for important information
* `-e TZ` for timezone information, Europe/London - see [Localtime](#localtime) for important information
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it radarr /bin/bash`.

## Localtime

It is important that you either set `-v /etc/localtime:/etc/localtime:ro` or the TZ variable, mono will throw exceptions without one of them set.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Access the webui at `<your-ip>:7878`, for more information check out [Radarr][appurl].

## Info

* Shell access whilst the container is running: `docker exec -it radarr /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f radarr`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' radarr`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/radarr`

## Versions

+ **15.12.17:** Fix continuation lines.
+ **17.04.17:** Switch to using inhouse mono baseimage, adds python also.
+ **13.04.17:** Switch to official mono repository.
+ **10.01.17:** Initial Release.
