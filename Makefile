SHELL := /bin/bash
IMAGE := rlogd/rlogd

build: build-debian build-alpine

build-debian:
	docker build -t $(IMAGE):debian ./debian/

build-alpine:
	docker build -t $(IMAGE):alpine ./alpine/

clean:
	docker image rm $(IMAGE):debian $(IMAGE):alpine

