FROM ubuntu

RUN apt-get update -qq
RUN apt-get install -y postgresql-client

ADD . /app
WORKDIR /app
