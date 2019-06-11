SHELL = /bin/bash
IMAGE = rlogd/rlogd
DIST ?= debian
DISTRIBUTIONS = debian alpine

.PHONY: build
build:
	docker build -t $(IMAGE):$(DIST) ./$(DIST)/

build-%:
	make DIST=$* build

.PHONY: build-all
build-all: $(addprefix build-, $(DISTRIBUTIONS))

.PHONY: clean
clean:
	docker image rm $$(for i in $(DISTRIBUTIONS);do echo $(IMAGE):$${i};done)

.PHONY: test
test:
	docker-compose up -d
	sleep 2
	docker-compose exec client cat /etc/issue
	for i in {1..10};do echo "xxxxxxxxxx xxxxxxxxx";done | docker-compose exec -T client rlogger -d -t unix:///var/run/rlogd/rloggerd.sock example.acc
	for i in {1..10};do echo "yyyyyyyyyy yyyyyyyyy";done | docker-compose exec -T client rlogger -d -t unix:///var/run/rlogd/rloggerd.sock example.err
	for i in {1..10};do echo "zzzzzzzzzz zzzzzzzzz";done | docker-compose exec -T client rlogger -d -t unix:///var/run/rlogd/rloggerd.sock example.app
	sleep 3
	docker-compose kill -s HUP rlogd
	docker-compose exec -w /var/log/rlogd/example/$$(TZ=UTC date +%Y-%m-%d) rlogd md5sum -c /checksum
	docker-compose down -v

test-%:
	make DIST=$* test

.PHONY: test-all
test-all: $(addprefix test-, $(DISTRIBUTIONS))
