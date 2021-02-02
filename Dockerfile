FROM debian:buster

RUN apt-get update && \
apt-get -y upgrade && \
apt-get install -y nginx