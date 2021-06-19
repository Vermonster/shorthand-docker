FROM node:12.22.1-alpine

RUN apk add --no-cache \
  bash \
  ruby ruby-dev \
  openjdk11-jdk ttf-dejavu \
  build-base \
  curl \
  make

RUN gem install bigdecimal json jekyll etc webrick

RUN mkdir -p /.npm-global
RUN npm config set prefix "/.npm-global"
ENV PATH="/.npm-global/bin:${PATH}"

RUN npm install --global fsh-sushi
RUN npm install --global gofsh

COPY VERSION  /etc
COPY bin /.npm-global/bin

WORKDIR /workspace
