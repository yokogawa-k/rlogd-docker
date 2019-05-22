ARG COMMIT_HASH=f1a4a4e3ce875b1bc56177e20ec2c66d06b72342

FROM alpine:3.9 AS build

RUN set -ex \
 && apk add --update --no-cache \
   git \
   bash \
   autoconf \
   automake \
   gcc \
   bsd-compat-headers \
   libc-dev \
   libev-dev \
   pcre-dev \
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

FROM alpine:3.9

ARG COMMIT_HASH

LABEL maintainer "YOKOGAWA Kazuya <yokogawa-k@klab.com>"
LABEL Description="rlogd docker image" Commit_Hash=${COMMIT_HASH}

RUN set -ex \
 && apk add --update --no-cache \
   libc6-compat \
   libev \
   pcre \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /rlogd/src/rlogd /usr/local/sbin/
COPY --from=build /rlogd/src/rloggerd /rlogd/src/rlogger /usr/local/bin/

CMD ["/usr/local/sbin/rlogd", "-F", "-d", "-p", "/var/run/rlogd.pid"]