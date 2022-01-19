FROM node:12.22.1-alpine

RUN apk add --no-cache \
  bash \
  ruby ruby-dev \
  openjdk11-jdk ttf-dejavu \
  build-base \
  curl \
  make \
  su-exec \
  perl

RUN gem install bigdecimal json jekyll etc webrick


RUN addgroup -S dev && adduser -S dev -G dev

USER dev

RUN mkdir /home/dev/workspace

RUN mkdir -p /home/dev/.npm-global
RUN npm config set prefix "/home/dev/.npm-global"
ENV PATH="/home/dev/.npm-global/bin:${PATH}"

RUN npm install --global fsh-sushi
RUN npm install --global gofsh

COPY VERSION /etc
COPY bin /home/dev/.npm-global/bin

WORKDIR /home/dev/workspace
VOLUME ["/home/dev/workspace", "/home/dev/.fhir"]

USER root
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["bash"]
