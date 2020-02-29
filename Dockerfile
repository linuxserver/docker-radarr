FROM lsiobase/ubuntu:focal

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RADARR_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ARG RADARR_BRANCH="aphrodite"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install --no-install-recommends -y \
	jq \
	libicu65 \
	libmediainfo0v5 \
	sqlite3 && \
 echo "**** install radarr ****" && \
 mkdir -p /opt/radarr && \
 if [ -z ${RADARR_RELEASE+x} ]; then \
	RADARR_RELEASE=$(curl -sL "https://radarr.lidarr.audio/v1/update/${RADARR_BRANCH}/changes?os=linux" \
	| jq -r '.[0].version'); \
 fi && \
 curl -o \
 /tmp/radarr.tar.gz -L \
	"https://radarr.lidarr.audio/v1/update/${RADARR_BRANCH}/updatefile?version=${RADARR_RELEASE}&os=linux&runtime=netcore&arch=x64" && \
 tar ixzf \
 /tmp/radarr.tar.gz -C \
	/opt/radarr --strip-components=1 && \
 echo "**** cleanup ****" && \
 rm -rf \
	/opt/radarr/Radarr.Update \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 7878
VOLUME /config
