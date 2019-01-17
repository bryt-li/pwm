NAME = pwm/pwm-webapp
VERSION = latest
REPO = 120896031351.dkr.ecr.ap-northeast-2.amazonaws.com/$(NAME)
PWM = https://github.com/pwm-project/pwm.git
.PHONY: all

all: pub

source:
	git clone $(PWM) $@

build: source
	cd source;mvn package

load: build
	docker load --input=source/docker/target/jib-image.tar

tag: load
	docker tag $(NAME):$(VERSION) $(REPO):$(VERSION)

pub: tag
	docker push $(REPO):$(VERSION)
