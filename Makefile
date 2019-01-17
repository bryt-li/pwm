NAME = pwm/pwm-webapp
VERSION = latest
REPO = 120896031351.dkr.ecr.ap-northeast-2.amazonaws.com/$(NAME)
PWM = https://github.com/pwm-project/pwm.git
.PHONY: all

all: pub

clone: pwm-source
	rm -rf pwm-source
	git clone $(PWM) pwm-source

build: clone
	cd pwm-source;mvn package

load: build
	docker load --input=pwm-source/docker/target/jib-image.tar

tag: load
	docker tag $(NAME):$(VERSION) $(REPO):$(VERSION)

pub: tag
	docker push $(REPO):$(VERSION)
