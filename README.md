rlogd(Reliable LOG Daemon) Docker Image
====

[![CircleCI](https://circleci.com/gh/yokogawa-k/rlogd-docker/tree/master.svg?style=svg)](https://circleci.com/gh/yokogawa-k/rlogd-docker/tree/master)
[![](https://images.microbadger.com/badges/image/rlogd/rlogd.svg)](https://microbadger.com/images/rlogd/rlogd "Get your own image badge on microbadger.com")

## What is rlogd?

Rlogd is an open source software for reliable log collection.

[Original repository](https://github.com/pandax381/rlogd)

## Supported tags and respective `Dockerfile` links

- `stretch`, `debian`, `latest` [(debian/Dockerfile)]
- `alpine` [(alpine/Dockerfile)]

## How to use this image

Starting a rlogd instance is simple:

```
$ docker run --name some-rlogd -d -v /path/to/dir:/usr/local/etc/rlogd/ rlogd/rlogd:tag rlogd -F -d -p /var/run/rlogd.pid -c /usr/local/etc/rlogd/rlogd.conf
```

Starting a rloggerd instance requires additional commands:

```
$ docker run --name some-rloggerd -d rlogd/rlogd:tag rloggerd -f 1 -l unix:///path/to/socket -t target -b path/to/buffer
```
