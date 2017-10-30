FROM lsiobase/mono
MAINTAINER sparklyballs

# environment settings
ENV XDG_CONFIG_HOME="/config/xdg"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install radarr
RUN \
 radarr_build=$(curl -H "Accept: application/xml" -sX GET \
    "https://ci.appveyor.com/api/projects/galli-leo/radarr-usby1/branch/develop" \
    | sed -n '/BuildNumber/{s/.*<BuildNumber>//;s/<\/BuildNumber.*//;p;}') && \
 mkdir -p \
	/opt/radarr && \
 curl -o \
    /tmp/radar.tar.gz -L \
    "https://ci.appveyor.com/api/projects/galli-leo/radarr-usby1/artifacts/_artifacts%2FRadarr.develop.0.2.0.${radarr_build#v}.linux.tar.gz" && \
 tar ixzf \
    /tmp/radar.tar.gz -C \
	/opt/radarr --strip-components=1 && \

# clean up
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 7878
VOLUME /config /downloads /movies
