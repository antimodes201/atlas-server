FROM antimodes201/steamcmd-base:1.0
MAINTAINER antimodes201

USER root
# dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
	apt-get install -y --no-install-recommends \
	libssl1.0.0 \
	libidn11 \
	librtmp1 \
	libgssapi-krb5-2 \
	libprotobuf10 && \
	rm -rf /var/lib/apt/lists/*

# Set some Variables
ARG QUERY_PORT=57550
ARG GAME_PORT_1=5750
ARG GAME_PORT_2=5751
ARG SEAMLESS_PORT=27000
ARG RCON_PORT=28000

ENV BRANCH "public"
ENV QUERY_PORT $QUERY_PORT
ENV GAME_PORT_1 $GAME_PORT_1
ENV GAME_PORT_2 $GAME_PORT_2
ENV SEAMLESS_PORT $SEAMLESS_PORT
ENV RCON_PORT $RCON_PORT
ENV TZ "America/New_York"
ENV TYPE "MASTER"
ENV ADDITIONAL_OPTS ""
ENV ADDITIONAL_ARGS ""
ENV ServerX "0"
ENV ServerY "0"

# work around for Grapeshot using out of date SSL
#RUN cd /usr/lib/x86_64-linux-gnu/ && \
#	ln -s libssl.so.1.1 libssl.so.1.0.0 && \
#	ln -s libcrypto.so.1.1 libcrypto.so.1.0.0

# troubleshooting - DELETE ME
RUN cd /usr/lib && \
find -name "libssl*" && \
find -name "libcrypt*"

USER steamuser

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $QUERY_PORT/udp
EXPOSE $QUERY_PORT/tcp
EXPOSE $GAME_PORT_1/udp
EXPOSE $GAME_PORT_2/udp
EXPOSE $SEAMLESS_PORT/tcp
EXPOSE $RCON_PORT/tcp

CMD ["/scripts/start.sh"]

