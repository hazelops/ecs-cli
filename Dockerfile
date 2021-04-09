FROM docker:latest

ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1

RUN apk add --update --no-cache \
  python3 \
  py3-pip \
  libffi && \
  apk add --no-cache --virtual .build-deps \
  build-base \
  libffi-dev \
  python3-dev \
  make \
  openssl-dev && \
  pip3 install docker-compose && \
  apk del .build-deps

ADD https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest /usr/bin/ecs-cli
RUN chmod +x /usr/bin/ecs-cli

ENTRYPOINT ["ecs-cli"]
