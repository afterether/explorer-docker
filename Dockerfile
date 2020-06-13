#Download base image ubuntu 18.04
FROM ubuntu:18.04

LABEL maintainer="afterether@gmail.com"
LABEL version="0.1"
LABEL description="Docker image to test Augur Explorer"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update

RUN apt-get install -y git
RUN apt-get install -y build-essential
RUn apt-get install -y curl

RUN apt-get install -y postgresql postgresql-contrib
RUN update-rc.d postgresql enable
RUN service postgresql start

RUN apt-get install -y supervisor
ENV supervisor_conf /etc/supervisor/supervisord.conf
COPY supervisord.conf ${supervisor_conf}
COPY start.sh /start.sh

# setup postgres and Explorer development user
COPY start-postgres.sh /start-postgres.sh
COPY setup.sql /setup.sql
COPY init-postgres.sh /init-postgres.sh
RUN /init-postgres.sh
RUN /bin/rm /init-postgres.sh
RUN /bin/rm /setup.sql

# install Go and NodeJS
COPY go.tar.gz /go.tar.gz
COPY node.tar.gz /node.tar.gz
COPY install-go-and-node.sh /install-go-and-node.sh
RUN /install-go-and-node.sh
RUN /bin/rm /go.tar.gz /node.tar.gz /install-go-and-node.sh

RUN apt-get install -y npm
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y yarn
RUN apt-get purge -y nodejs
RUN apt-get autoremove -y

COPY install-augur.sh /install-augur.sh
RUN su - aedev -c /install-augur.sh
RUN /bin/rm /install-augur.sh

CMD exec /start.sh > /tmp/startup.log

