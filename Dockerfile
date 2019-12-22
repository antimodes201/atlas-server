FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

# Set some Variables
ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV GAME_PORT "7777"
ENV GAME_PORT2 "7778"
ENV QUERY_PORT "27015"
ENV RCON_PORT "27020"
ENV ADDITIONAL_ARGS ""
ENV TZ "America/New_York"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		lib32gcc1 \
		libc6-i386 \
		libssl1.0.0 \
		libidn11 \
		wget \
		unzip \
		tzdata \
		redis-server \
		jq \
		dnsutils \
		curl \
		perl-modules \
		lsof \
		bzip2 \
		software-properties-common \
		ca-certificates && \
		rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /usr/games \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /usr/games \
		&& chown steamuser:steamuser /scripts

USER steamuser

RUN	cd /usr/games && \
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
	tar -xf steamcmd_linux.tar.gz && \
	rm steamcmd_linux.tar.gz && \
	./steamcmd.sh +quit

USER root
RUN	ln -s '/usr/games/steamcmd.sh' '/usr/games/steamcmd' && \
	cd /home/steamuser/ && \
	curl -sL http://git.io/fh4HA |  bash -s steamuser
	
RUN chown steamuser:steamuser /etc/atlasmanager/instances/*.cfg



ADD start.sh /scripts/start.sh
ADD atlasmanager.cfg /etc/atlasmanager/atlasmanager.cfg
RUN chown steamuser:steamuser /etc/atlasmanager/atlasmanager.cfg

USER steamuser

# Expose some port
EXPOSE ${GAME_PORT}/udp
EXPOSE ${GAME_PORT2}/udp
EXPOSE ${QUERY_PORT}/udp
EXPOSE ${RCON_PORT}/tcp

# Make a volume
# contains configs and world saves
VOLUME /atlas

CMD ["/scripts/start.sh"]
