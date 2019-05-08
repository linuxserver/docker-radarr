FROM lsiobase/mono:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG RADARR_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"

RUN \
 echo "**** install jq ****" && \
 apt-get update && \
 apt-get install -y \
	jq && \
 echo "**** install radarr ****" && \
 if [ -z ${RADARR_RELEASE+x} ]; then \
	RADARR_RELEASE=$(curl -sL GET https://ci.appveyor.com/api/projects/galli-leo/radarr-usby1/history?recordsNumber=100 | \
	jq -r '. | first(.builds[] | select(.status == "success") | select(.branch =="aphrodite")) | .version'); \
 fi && \
 RADARR_JOBID=$(curl -s "https://ci.appveyor.com/api/projects/galli-leo/radarr-usby1/build/${RADARR_RELEASE}" | jq -jr '. | .build.jobs[0].jobId') \
 RADARR_DURL="https://ci.appveyor.com/api/buildjobs/${RADARR_JOBID}/artifacts/_artifacts/Radarr.aphrodite.${RADARR_RELEASE}.linux.tar.gz"; \
 mkdir -p \
	/opt/radarr && \
 curl -o \
 /tmp/radar.tar.gz -L \
	"${RADARR_DURL}" && \
 tar ixzf \
 /tmp/radar.tar.gz -C \
	/opt/radarr --strip-components=1 && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 7878
VOLUME /config /downloads /movies
