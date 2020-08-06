FROM klakegg/hugo:0.74.3
# https://github.com/klakegg/docker-hugo

ARG HUGO_VERSION=graviteeio

ARG HUGO_BASE_URL
ENV HUGO_BASE_URL=${HUGO_BASE_URL}

RUN mkdir -p /gravitee-bot/.secrets
VOLUME /gravitee-bot/.secrets
