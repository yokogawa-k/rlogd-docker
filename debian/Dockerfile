ARG COMMIT_HASH=a03a2e58baef837fd15902144b9516b32319b6a0

FROM debian:stretch AS build

ENV DEBIAN_FRONTEND noninteractive
RUN set -ex \
 && apt-get update \
 && apt-get -y --no-install-recommends install \
   git \
   ca-certificates \
   autoconf \
   automake \
   gcc \
   libev-dev \
   libpcre3-dev \
   make

RUN set -ex \
 && git clone https://github.com/pandax381/rlogd.git

WORKDIR rlogd
ARG COMMIT_HASH
RUN set -ex \
 && git checkout ${COMMIT_HASH} \
 && ./autogen.sh \
 && ./configure \
 && make

FROM debian:stretch-slim

ARG COMMIT_HASH

LABEL maintainer "YOKOGAWA Kazuya <yokogawa-k@klab.com>"
LABEL Description="rlogd docker image" Commit_Hash=${COMMIT_HASH}

ENV DEBIAN_FRONTEND noninteractive
RUN set -ex \
 && apt-get update \
 && apt-get -y --no-install-recommends install \
   libev4 \
   libpcre3 \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /rlogd/src/rlogd /usr/local/sbin/
COPY --from=build /rlogd/src/rloggerd /rlogd/src/rlogger /usr/local/bin/

CMD ["/usr/local/sbin/rlogd", "-F", "-d", "-p", "/var/run/rlogd.pid"]
