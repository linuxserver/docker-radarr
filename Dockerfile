FROM lsiobase/xenial
MAINTAINER sparklyballs

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	libcurl3 \
	libmono-cil-dev \
	mediainfo \
	unzip && \

# install radarr
 curl -o \
 /tmp/radarr-app.zip -L \
	https://leonardogalli.ch/radarr/builds/latest.php?os=mono && \
 unzip -d /tmp /tmp/radarr-app.zip && \
 mv /tmp/Radar* /opt/radarr && \

# clean up
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 7878
VOLUME /config /downloads /movies
