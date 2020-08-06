FROM klakegg/hugo:0.74.3-alpine
# https://github.com/klakegg/docker-hugo

ARG HUGO_VERSION=graviteeio

ARG HUGO_BASE_URL
ENV HUGO_BASE_URL=${HUGO_BASE_URL}

RUN mkdir -p /gravitee-bot/.secrets

COPY hugo-bootstrap.sh /gravitee-bot
RUN chmod +x /gravitee-bot/hugo-bootstrap.sh

RUN apk update && apk add curl bash

VOLUME /gravitee-bot/.secrets

WORKDIR /gravitee-bot
ENTRYPOINT [ "/gravitee-bot/hugo-bootstrap.sh" ]
