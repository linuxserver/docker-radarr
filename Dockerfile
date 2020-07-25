FROM lsiobase/mono:LTS

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RADARR_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ARG RADARR_BRANCH="nightly"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install jq ****" && \
 apt-get update && \
 apt-get install -y \
	jq && \
 echo "**** install radarr ****" && \
 if [ -z ${RADARR_RELEASE+x} ]; then \
        RADARR_RELEASE=$(curl -k "https://radarr.servarr.com/v1/update/${RADARR_BRANCH}/changes?os=linux" \
        | jq -r '.[0].version'); \
 fi && \
 radarr_url=$(curl -k -sX GET "https://radarr.servarr.com/v1/update/${RADARR_BRANCH}/changes?os=linux" |jq -r ".[] \
	| select(.version == \"${RADARR_RELEASE}\") | .url") && \
 mkdir -p \
	/app/radarr/bin && \
 curl -o \
 /tmp/radar.tar.gz -L \
	"${radarr_url}" && \
 tar ixzf \
 /tmp/radar.tar.gz -C \
	/app/radarr/bin --strip-components=1 && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 7878
VOLUME /config
