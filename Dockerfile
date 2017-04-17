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
 radarr_tag=$(curl -sX GET "https://api.github.com/repos/Radarr/Radarr/releases" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 mkdir -p \
	/opt/radarr && \
 curl -o \
 /tmp/radar.tar.gz -L \
	"https://github.com/galli-leo/Radarr/releases/download/${radarr_tag}/Radarr.develop.${radarr_tag#v}.linux.tar.gz" && \
 tar ixzf \
 /tmp/radar.tar.gz -C \
	/opt/radarr --strip-components=1 && \

# clean up
 rm -rf \
	/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 7878
VOLUME /config /downloads /movies
