FROM lsiobase/mono

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install jq ****" && \
 apt-get update && \
 apt-get install -y \
	jq && \
 echo "**** install radarr ****" && \
 radarr_url=$(curl "http://radarr.aeonlucid.com/v1/update/nightly/changes?os=linux" \
	| jq -r '.[0].url') && \
 mkdir -p \
	/opt/radarr && \
 curl -o \
 /tmp/radar.tar.gz -L \
	"${radarr_url}" && \
 tar ixzf \
 /tmp/radar.tar.gz -C \
	/opt/radarr --strip-components=1 && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 7878
VOLUME /config /downloads /movies
